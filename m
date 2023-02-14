Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C569718B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 00:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjBNXGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 18:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjBNXGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:06:09 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC4311DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 15:05:40 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id v13so5358477iln.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 15:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0NgkeBMMJp25GutovHDy5uGqqIv+F0wnILJzPaqVk=;
        b=D86ZlEmgPn6zYt3h9LajOUBIj2lvYD/XRL387/aIgai9cGLaVo7W+YT6/UFZKMx6tZ
         HzN/V11U6WHzjiu9lexALsC+tsagFh6XUFVXDvOO8C83W2GtEm2YwggXWicEO1kaGfzr
         1zQNQhmbEWp0e57sHLzueTwkD417gRp5NHhEttVzDeJfgmt1qNNkzv+tlG9rbZst3zbj
         1K95FQ6n5QVsqZgsPMKk03iFqrqEyr3X/gPH4e6GY8IeeWLlg1+DYwK3lIX958W373i6
         dFJv7jP+9u9e6kBNwIg0kWamyyc0wfAeD9Z/LqAyu7fbjcC4zTcIx9J6UVIMzdGPp9YE
         otCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0NgkeBMMJp25GutovHDy5uGqqIv+F0wnILJzPaqVk=;
        b=ZTFTJe7hHYJhqbNjcRegMsQSLCx/dp61FQ+MTM/keS64EyeyXrlEYizgKYwq+r9NZa
         ocraxf7GyAWswqbJiBP+Aah7p+QhS1PlLshJKCb/RS/UTkqWVnMllO+jrE/A3/l0A2ZZ
         H5q+4+g2NERC5WpRTU/fatHuG8Do5QOiiFkmaJoSlS7cDNb+KsVHaLal0SV1dS5naNUs
         9XGqPqlolBDiKNfw0lbSe4F0rgIn4lpzJZpiLrY+EtWVNN1dI5S8fk+QTMDZAkUFvKnB
         hrdrCJ9rPCqYHFAZmgRxt8yzq70V9etgI7xglTYiOuofvV7j4tf2DXOU2KDlhC8e5Upm
         gtzA==
X-Gm-Message-State: AO0yUKUj2chuS/utskvBbwjftMhGUWwyhOEpowt9aqqrO41dVXKpx80O
        k3cDB/JXjKWIe3sVt9c+gwe/+A==
X-Google-Smtp-Source: AK7set87wxmTDwtJRW0ye8r7q7aTzqoBfwNDT61LNDbHNlSoCq27WRJgV4Hmj4Wykio2W70BOuSA8w==
X-Received: by 2002:a05:6e02:1e05:b0:315:579c:9b77 with SMTP id g5-20020a056e021e0500b00315579c9b77mr308762ila.1.1676415931247;
        Tue, 14 Feb 2023 15:05:31 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a02cca5000000b003b1f0afe484sm5239206jap.141.2023.02.14.15.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 15:05:30 -0800 (PST)
Message-ID: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk>
Date:   Tue, 14 Feb 2023 16:05:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, smfrench@gmail.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <2877092.1676415412@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2877092.1676415412@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/23 3:56 PM, David Howells wrote:
> Hi Jens,
> 
> If you decide not to take my patches in this merge window, would you have any
> objection to my patches 1-3 and 10-11 in this series going through Steve
> French's cifs tree so that he can take my cifs iteratorisation patches?
> 
> Patches 1-3 would add filemap_splice_read() and direct_splice_read(), but not
> connect them up to anything and 10-11 would add iov_iter_extract_pages().  I
> can then give Steve a patch to make cifs use them as part of my patches for
> that.
> 
> This would only affect cifs.  See my iov-cifs branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs
> 
> for an example of how this would look.

Let's update the branch and see how it goes... If there's more fallout, then
let's make a fallback plan for the first few.

-- 
Jens Axboe


