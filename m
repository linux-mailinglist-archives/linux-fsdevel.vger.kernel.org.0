Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF335258B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359583AbiELXsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 19:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359629AbiELXsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 19:48:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302D1D48DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:48:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v11so6192324pff.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dw/nJuFN8xUijchcBKsnvIN59wcmZ/h3OJIRc6fe3AU=;
        b=voPjMzHwLS5Khs0vmampZI7tDs45dTz85U06IIdOx45jQTd2IsU1+YertvigJMTCu8
         tqeK6x6YJv5uxlfEBvA/8Ur7CretFGngxW/lcjBMh99GW+SiUnkTpQ/UZ1tO13014NNc
         CyN2iK6VBtzRHCRU3G2kFwklR4kz4kYnCd0XQJaZooJBPfaCXQ18/Q/uR4a1X8VhOtwH
         ayaJ54ehCrdcrwa4IhfezTVxWt3ni4Ay724DSeB/CB2/g71D7xYZEj/OZWx19i0r62eD
         KGQ9gdzopbeE8ly9JhtxvbIwwrM4fxX/SPNRbX50QHvMY+iCK9+gXZHbEhLKY7kTtiS5
         haIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dw/nJuFN8xUijchcBKsnvIN59wcmZ/h3OJIRc6fe3AU=;
        b=BCx1bv/TXHAVqhY5Ti6stnlYBUxzKeqTUFXIUaViYn0lqgkTl845vMsqFEg9Y5lGqr
         RlFT2Z17F9uWGdOJbDL9Erc6SrLEFv5zQTZZFMRzJMCNIywTE7KXh4FIWrwmDszwkUIU
         /GTGFHPX6BaX8FyrrF2s3lpQ1vHlAi9paUWcmBOedz6SJPAMZdi58bMf39gQAXiKPYtG
         e9XcAvGukaqBjEOXfAIulPu8Gp/o46pL1qZxe6xOsjIO+GfUVgUEAS6+O6WdZEEkCpV6
         AI80z+TP4PuSYBGeyZvLY+du6Du/sZ+dLdxzLMbDsprHay2uGBZvV/BOBjDWc0qmYdlj
         hYSg==
X-Gm-Message-State: AOAM531jbNUk5h5s/3L5CeoJkaJUjT44IDBqxRBt/a/zOThjkbgRdpJd
        yZN9V0v9zZvRQ4b9BwaLhBs9wg==
X-Google-Smtp-Source: ABdhPJzeJ2L/RzcGYdSW7Tm1Ih1GC2PY0//E5q2/uv9nmRMptFQ/l+2l8BxXtuDLwrItoB4Ti4mCAA==
X-Received: by 2002:a05:6a00:a85:b0:506:b9e:7f43 with SMTP id b5-20020a056a000a8500b005060b9e7f43mr1753107pfl.5.1652399327517;
        Thu, 12 May 2022 16:48:47 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902ca1400b0015e8d4eb2acsm413952pld.246.2022.05.12.16.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:48:46 -0700 (PDT)
Message-ID: <4239a930-2765-a798-4831-d7c0d135c681@kernel.dk>
Date:   Thu, 12 May 2022 17:48:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] unify the file-closing stuff in fs/file.c
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/22 3:20 PM, Al Viro wrote:
> 	Right now we have two places that do such removals - pick_file()
> and {__,}close_fd_get_file().
> 
> 	They are almost identical - the only difference is in calling
> conventions (well, and the fact that __... is called with descriptor
> table locked).
> 
> 	Calling conventions are... interesting.
> 
> 1) pick_file() - returns file or ERR_PTR(-EBADF) or ERR_PTR(-EINVAL).
> The latter is for "descriptor is greater than size of descriptor table".
> One of the callers treats all ERR_PTR(...) as "return -EBADF"; another
> uses ERR_PTR(-EINVAL) as "end the loop now" indicator.
> 
> 2) {__,}close_fd_get_file() returns 0 or -ENOENT (huh?), with file (or NULL)
> passed to caller by way of struct file ** argument.  One of the callers
> (binder) ignores the return value completely and checks if the file is NULL.
> Another (io_uring) checks for return value being negative, then maps
> -ENOENT to -EBADF, not that any other value would be possible.
> 
> ERR_PTR(-EINVAL) magic in case of pick_file() is borderline defensible;
> {__,}close_fd_get_file() conventions are insane.  The older caller
> (in binder) had never even looked at return value; the newer one
> patches the bogus -ENOENT to what it wants to report, with strange
> "defensive" BS logics just in case __close_fd_get_file() would somehow
> find a different error to report.
> 
> At the very least, {__,}close_fd_get_file() callers would've been happier
> if it just returned file or NULL.  What's more, I'm seriously tempted
> to make pick_file() do the same thing.  close_fd() won't care (checking
> for NULL is just as easy as for IS_ERR) and __range_close() could just
> as well cap the max_fd argument with last_fd(files_fdtable(current->files)).
> 
> Does anybody see problems with the following?

Looks good to me, and much better than passing in the pointer to the
file pointer imho.

-- 
Jens Axboe

