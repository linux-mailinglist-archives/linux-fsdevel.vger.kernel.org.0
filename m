Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F9692A23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 23:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjBJWbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 17:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjBJWbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:31:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4657FEE3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:31:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n3so4702751pgr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676068281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aakxc4GOV3A+tpqp5NT+fjFwCBvuUL/gF53A5SHyoUM=;
        b=HBH4bzAOC+oGh0kd3NDtdX8oHQ3DvT4RC4HcqvIizHcpV3n2xpZ/i1ygDv66g0a0sz
         fFmff/ydUHcr/+X2vhiNoX77AcEuuGESI7j171BtOjbkWmpMD2QfCuA7NdgR/VhtVKwT
         959h2p2pCsk5upGFRWYhsUCl1xERt5f2ImVJMAbxm8vJkVPoFxvHGobgGpIC1ybTOr1B
         i+fSVnx3B+YtsCrjnAxxvCy+a0eCqMxootp6C/nLWjjOkhIUlwlQEX+GZMBKjdJp4LW/
         7mbD5YtOeKlIGfXKM9Lsh+r8K+Gycd3zKi2QOVLeyS/3775+KxgyKXzpAs/0kWCOQLdJ
         Ce/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676068281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aakxc4GOV3A+tpqp5NT+fjFwCBvuUL/gF53A5SHyoUM=;
        b=eCvZE0QIoQKRBkQRel4eYqHokVbnU7Y1ZwpY4R633fWqd2y0LQZBgObY+qxIBV+Gbu
         BHYM48ebl3j9fCpsXQfELfblI9vxcpFvicb0ZY+fA0LMCfxq9OaxQyrovVR+xzGuJjx6
         Ta88VtoRu6UWPq7lITUzPZU+WWI1uIzd7RAxOL6Ws1rsYFD5oy6B6YmFBsTOb9aOIywf
         yxL7Rlw+OAZfg/mj7cwUz+DMjRvdBbuhYphOMzxhRFh43McaiHJVqXKR7CLQOZnTQCr1
         KGWWDyvC60pkzcGZGBhmKx7elpymkX5O4oTIvSw6lCYbr5NmSik/gym6tDtMFntrqVko
         JkkQ==
X-Gm-Message-State: AO0yUKXM4xUPf2knzhdnYZX0X/NKzz3E4jnsqahquHcywT+uACiJfWv3
        Ib8frN1t1njsqEJuJ0Rqpi/JWA==
X-Google-Smtp-Source: AK7set9JzFtLT/BkCdAXDmaqIpgx7y6Q9b2lrPWOatxAvPOrDATXsIJKYQICCZAwhqj/4NCuYVdPag==
X-Received: by 2002:a62:d115:0:b0:5a8:1637:1f03 with SMTP id z21-20020a62d115000000b005a816371f03mr11992803pfg.1.1676068281172;
        Fri, 10 Feb 2023 14:31:21 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b00593ce7ebbaasm3710342pfn.184.2023.02.10.14.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:31:20 -0800 (PST)
Message-ID: <bee8b687-df78-baf8-495c-099d44f39275@kernel.dk>
Date:   Fri, 10 Feb 2023 15:31:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v13 00/12] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230209102954.528942-1-dhowells@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230209102954.528942-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/23 3:29?AM, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> Here are patches to provide support for extracting pages from an iov_iter
> and to use this in the extraction functions in the block layer bio code.

[snip]

I updated the branch to v13, just as a heads-up. Still in
for-6.3/iov-extract as before.

-- 
Jens Axboe

