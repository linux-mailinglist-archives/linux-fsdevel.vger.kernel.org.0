Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4921F5F71FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiJFXon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiJFXol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:44:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DAF55AD
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:44:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fw14so3019904pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NlArmLem3+xoNVUL3qvz0QUdQeCESF9oF8ZR1NUYAYY=;
        b=jxWosz8E89/ApnnR2BnBecvrS3iYj8rGYUMdWqRo9W9rS2S66Ki1v/9OEC6U2cy2Eb
         efJfwn2EsmCyuHKeoSxNxBSwlfLEsaTuBttmtNi/bEwakn8FUqr1fibN6sytU8RipctE
         a7pZeMglAy3pvRaqnuMS5R4mALJVpba2vjhHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NlArmLem3+xoNVUL3qvz0QUdQeCESF9oF8ZR1NUYAYY=;
        b=DCMSZy0HoP28HHu8A5+SBLKMcdSTKwU/XLBEeizovcPAkfhl5dilnI8OVSUdBHcaFy
         0SaTlSQ86W3apRE3Z37WqPfEm68tq4QRihcmUoN9DoAR4iIL9Se5Gg4+QkyGD9ycbbbN
         Jnens3FiWRAMKZ7+GVeQHmDZiMByPgcSv/Mo2293snCfZWNO1ld5getfCD00WK+FKZU0
         cI3T8ormfCqLGjmQYZdcKQE7h893P1NpoZmJr2is/AB/0BEZCRq1FFTqfnKtRxyGsU5a
         q/qFRBNGyPcOfzcg6OzRKB9EVYgFGXvenmCTWY68mvMkk7bdRRVak3ACP+bvglu1XZEb
         8PMQ==
X-Gm-Message-State: ACrzQf15hvBZTfsSUQGFXvS5BX3pANTKtqs0Bxvf0/K4vcsCQH5LMvW+
        4eG63rCQKxYzuCm9ktnA5APs/QhgL9WX+w==
X-Google-Smtp-Source: AMsMyM7XJr19aAjgKoAXmQLoSyku9WgL6ZNnbYxFz1ry4BwyGgVBUGSFJ7dXuBOZ7aA7x9WuBDhtDg==
X-Received: by 2002:a17:902:aa89:b0:178:a537:f386 with SMTP id d9-20020a170902aa8900b00178a537f386mr1897895plr.124.1665099879973;
        Thu, 06 Oct 2022 16:44:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b0017f8290fcc0sm155357plh.252.2022.10.06.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:44:39 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:44:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 4/8] pstore: Alert on backend write error
Message-ID: <202210061644.6FB59099@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-5-gpiccoli@igalia.com>
 <202210061625.950B43C119@keescook>
 <55cceaf8-acd4-22e2-61b5-99fff4ad5d75@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55cceaf8-acd4-22e2-61b5-99fff4ad5d75@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:34:44PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:27, Kees Cook wrote:
> > [...]
> >> --- a/fs/pstore/platform.c
> >> +++ b/fs/pstore/platform.c
> >> @@ -463,6 +463,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> >>  		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
> >>  			pstore_new_entry = 1;
> >>  			pstore_timer_kick();
> >> +		} else {
> >> +			pr_err_once("backend (%s) writing error (%d)\n",
> >> +				    psinfo->name, ret);
> > 
> > We're holding a spinlock here, so doing a pr_*() call isn't a great
> > idea. It's kind of not a great idea to try to write to the log in the
> > middle of a dump either, but we do attempt it at the start.
> > 
> > Perhaps keep a saved_ret or something and send it after the spin lock is
> > released?
> > 
> 
> Hi Kees, thanks a lot for the very quick review!!
> 
> Agree with you, I'll rework this one.
> Do you agree with showing only a single error? For me makes sense since
> we just wanna hint advanced users (+ people-debugging-pstore heh) that
> something went wrong.

Yeah, I agree -- it's going to be for folks working on pstore code. :)

-- 
Kees Cook
