Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05863C85D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiK2T2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiK2T2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:28:07 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444886F80B;
        Tue, 29 Nov 2022 11:26:00 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3c21d6e2f3aso88834447b3.10;
        Tue, 29 Nov 2022 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJmmkqr69JkQ4qKDXYBd8Y2fTOooZBZ0akE2PF6PQ8I=;
        b=FcVTlQgh18//wOeXZdSMsMRdgcpP2Q7+PGR65FmjHBta8kcOkc6u+oEOiYNWvK1O8U
         pjugnOX31UffvaYNeBAwEuJmN3MGM/I2jVgXX27TjmYjA5r9IcZtFaLDR79xe0C8FNtC
         jUCNzN8pd2dzo2mS6w6Ho072PH2+iHrAHUNPc9GVy5CyhRAMTQpXlOWXvEts+J9cqP20
         CmNGEG/7KXCYIi/yDyXZcUE9I6OL3SZtko8pzX6pXdvF1F0vKizcWbemgOnghv59wZXv
         ivqulFzBFAXtEt1DVxQdf0cLVK4QxY9uRto7KVEEUvqzSVbIkG0hYPTgL+GEgtc/vtiy
         aivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJmmkqr69JkQ4qKDXYBd8Y2fTOooZBZ0akE2PF6PQ8I=;
        b=m07lVEWcCr78kdAQbdfYyEconkDCosW6N8y2xgZG7lWNKvsz5XjFD8/e3eAsMK+Eqz
         WMNpb4YVFTL/B5MpC7KBl09UIvhw3HGPBW28KCHmsTdq0wRuMA848DMpdwAW0zt5FfaA
         PuBiE+EAwv+8l2EXYZV1GPPPBMGTtD75uTKOIa5hqwfvVXUhg0WdmLzFHp4xtiAVrH3+
         jSRGmbWkRjYcBoiuU3DgWHVHPza5dkQEL69+ZyBFn1nniUeD7MGrJ3GQP3FKMH2G3VTl
         6y6pKTXDqZLiLGVHlSFvsOyV7GaKAgGFj5/KQ+XjbZ2RMr6yh9W8SRouZbK6Yui9/IqY
         /zug==
X-Gm-Message-State: ANoB5pnFaXJZ42zI2oofwKjcS7k4HjGy80usx/f7M5dzNNrxUoookH34
        E9QoAN1PPnBCthDdOC+mhBhrzUVA1Jeb/PF2pH/mr4yn
X-Google-Smtp-Source: AA0mqf7QBVwYyYJOy68rRZkOsISPyAoocPI/jaNNO4mPUqutAvMlsDXDGlRiLDZ56E1jJsFlijQxO2lxJl4V6Xd4ZvI=
X-Received: by 2002:a0d:eb08:0:b0:3c1:1bd:657a with SMTP id
 u8-20020a0deb08000000b003c101bd657amr15902914ywe.142.1669749959392; Tue, 29
 Nov 2022 11:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20221101175326.13265-1-vishal.moola@gmail.com>
In-Reply-To: <20221101175326.13265-1-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 29 Nov 2022 11:25:48 -0800
Message-ID: <CAOzc2px-5sYh-=_0+J_-km3E10tTDjQS7d0uP1dcqGuZoUW6vA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Removing the lru_cache_add() wrapper
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 1, 2022 at 10:53 AM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> This patchset replaces all calls of lru_cache_add() with the folio
> equivalent: folio_add_lru(). This is allows us to get rid of the wrapper
> The series passes xfstests and the userfaultfd selftests.

All of these patches have been reviewed. Andrew, is there anything
you'd like to see changed, or will you take these?
