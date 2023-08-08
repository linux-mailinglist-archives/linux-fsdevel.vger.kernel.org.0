Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6947A774BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjHHVCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjHHVB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:01:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE564C2B
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 14:01:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso4302779b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691528516; x=1692133316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=md5bxPWMzWtFYHeGnGMZwyZT+x0wexWDG9PTlIVjE/I=;
        b=Fgug0W2a9pGm9mZr+L8vD1pYzq5E7GBToZcQO53iOOE0Hi2DzANaVG4Z41u2KN+OUY
         gQ7HtJw/wTCmMRNZxpWcnasB6iFE4HS3PqW+ysbe02jd0wtPaYyU/GlZVRTlkJo6XMsK
         xVqOvQPQOoO+6zXabNf3TaHTsQDQF6JQBW848=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528516; x=1692133316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5bxPWMzWtFYHeGnGMZwyZT+x0wexWDG9PTlIVjE/I=;
        b=K/SfjIj/cfeHDALX0dozUhRny9O+qQJ6BjO5ZHQ8WCwx6qFEgjlaGR7PCig1VrOlPN
         vqNYLkCdpoJOT1EWmWuVIiRIwO+AnSqtdYUAFTiA+IjlaOmEFvQCtkhpAZApL9tXJExd
         kNIBWeAfUQp1PY6pCqqc9IEvtkt/+dPaTvNqhn8IY3FshoefvtNv4sZk9XXTVWRSDhjf
         hgdZft3/ukSRXeaCGvxKXOzCh47/Vs4HL9gSDIbwuo+DLJTgLHyEiYYp+Vsu6abOFA9A
         S6m65bAMPXs321mJykQDTRIOtjeNQomSwVspoOd/W68nyQUFsu+xQc43xHQDLKLTMDhR
         YfNA==
X-Gm-Message-State: AOJu0Yyye8vZxy8rT4L3ywPq5Qxw124Hso4PKopRUuaEWU95yEpYb22M
        9zHRThvfRlGYqoPOqZ1/58OLsw==
X-Google-Smtp-Source: AGHT+IHjDIGjlwfIIWXW8zPDw9oXg62J5upaCULmixQuLvDspSMI2wuW4rp2oL7qrabjsMNGaLrFIQ==
X-Received: by 2002:a05:6a21:3e0c:b0:131:6464:217b with SMTP id bk12-20020a056a213e0c00b001316464217bmr623397pzc.16.1691528516351;
        Tue, 08 Aug 2023 14:01:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b001a1b66af22fsm9452942plr.62.2023.08.08.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:01:55 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:01:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
Message-ID: <202308081401.A9C03BBCF5@keescook>
References: <20230720151458.never.673-kees@kernel.org>
 <169040854617.1782642.4557415464507636357.b4-ty@chromium.org>
 <20fc56ef-6240-e86e-6d38-9278592a3b25@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fc56ef-6240-e86e-6d38-9278592a3b25@lwfinger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:20:06PM -0500, Larry Finger wrote:
> On 7/26/23 16:55, Kees Cook wrote:
> > 
> > On Thu, 20 Jul 2023 08:15:06 -0700, Kees Cook wrote:
> > > The declaration of struct shfl_string used trailing fake flexible arrays
> > > for the string member. This was tripping FORTIFY_SOURCE since commit
> > > df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
> > > utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
> > > member, and retriain a 2 byte padding to keep the structure size the same.
> > > 
> > > 
> > > [...]
> > 
> > Applied to for-linus/hardening, thanks!
> > 
> > [1/1] vboxsf: Use flexible arrays for trailing string member
> >        https://git.kernel.org/kees/c/a8f014ec6a21
> 
> Kees,
> 
> This patch has not been applied to kernel 6.5-rc5. Is there some problem?

Hi! Sorry, I was waiting for linux-next testing, and then got distracted
on Friday. I will send the PR to Linus today.

Thanks for the poke!

-Kees

-- 
Kees Cook
