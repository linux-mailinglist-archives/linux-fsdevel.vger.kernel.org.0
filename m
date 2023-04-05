Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9016D7DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjDENe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjDENe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:34:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9F4C15
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 06:34:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3261b76b17aso1179085ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680701665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+CwkkX40YD6GiL/QPdmYDOm3IjGvaN6PvuLBJI8B70=;
        b=F3bjlMyCof1RWee9b43GG76KYPLck9/tyXmosXsq6KUbxXyI+zN9L2oX8/AZP4uzh1
         rTW5x1WRCwCXDXrNj9VPdliBso12eUaNfKFb7Ggoyilt4LdQtdeHtOYdDpBeJFy0vjuk
         kMw0oBBCI73IdDjQTf/I96KExIHBSIAM9x36xa8o0K9QqXGjV87F4jxftiX0rvhVDD9k
         Ol40ZiEfXsRqUTpzwLVvZnamQQzH3P9t153F57Vvyrivb3ZTteoeuOBlBQEcMzX9QJuF
         J6bhV7CGS6sj0PJBgrevT3+Qoy2zB7xwvYOyk+HQ5jLs+Db7X1T8+HVXu6IGpLGYsxc5
         z1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+CwkkX40YD6GiL/QPdmYDOm3IjGvaN6PvuLBJI8B70=;
        b=Y6aMzKl4ATQ6dH9CiIAtaAOJPk33g9oY780wHpC8+9zHqbczNltrOB7Mu/ROLiAvca
         vb805NwYrARQxfRx+cEeKAV8/z6pF5ew+9KsGEC1vf24EG8CxIEhIPR72IL03Bwa2WQO
         9ukfY6xFNM0SY3NJpyKfnO1zJADoDdIlIeqMYIqWVL7/QGBmDAWvSuvMAz5yUjnrbcDm
         vozTQ9DVG0RmlEZ5Uf/UJeXr2rOmX/9AHzjAqjErOF8zkyzL9GLMDCT/vrVcpj96M/4s
         z2swp29I7dh1plVzAcJv4rEL8TdXcYhSuseYsio6AtMbum+g6Rv4D0+wM1XfWwKG5fAK
         5yGg==
X-Gm-Message-State: AAQBX9d+Hxke1VuE3XTakRtVACf2ObqBvF6FAlt+AZTiYYRrJOrUZn8z
        AFdhpbIoq6Uj3Ouug3bQP8D74z7Fw4CW4w+t6Y2hWw==
X-Google-Smtp-Source: AKy350amKQOfi/el/3wzuFjrm7LDTuCEPWt2eESN6efZ27TydrLztun8/ipSAfxed6gTCvksYnJ2zQ==
X-Received: by 2002:a05:6e02:20c2:b0:326:3b2e:95b1 with SMTP id 2-20020a056e0220c200b003263b2e95b1mr2031608ilq.2.1680701665346;
        Wed, 05 Apr 2023 06:34:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p12-20020a056e02104c00b003141b775fbasm3923483ilj.16.2023.04.05.06.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:34:24 -0700 (PDT)
Message-ID: <15487b3f-62cc-ae99-6a86-abe251808fcf@kernel.dk>
Date:   Wed, 5 Apr 2023 07:34:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: two little cleanups for the for-6.4/splice branch
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230403142543.1913749-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230403142543.1913749-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/3/23 8:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes two now unused functions.

Looks good to me. David? I'll add them to the splice branch.

-- 
Jens Axboe


