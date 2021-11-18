Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705BC455B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbhKRMk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 07:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244311AbhKRMk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:40:56 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61786C061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 04:37:56 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id i13so4448336qvm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MPZiBVeMHca1j4Sh9MPQqbWDzkaYge/S5imT36JhPo0=;
        b=SYi9hppxJ4ix9DA/KEdQXfavJ9uqAh1woI869x36PZEEGGlS737M3+mnRYiMmF48fO
         2wLudny3iG6Y+hEZkSmdAXmo7c5YS7DMnr9H9L6HNutg9zVlm+DZoYWJsYSx3P0Jx0mE
         Yvn7KH7EoRywm6onRs+6L2vJMCHvkzNF7DdQBBnqJj5qRgt6dhejYuC0ET/L44bHwUsv
         70DAn1Z28MAatm55OYIxzwOAldghicpQJQwR/c7gXUMhXiToYNG0uWDKFpmhxsBe6JHx
         RJZryBQSmVCQXIpfxSErm9WpyHQoOfyRQC4l/8lrxmxphSNnD+bgR70lBVfKtuc7MxiU
         PNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=MPZiBVeMHca1j4Sh9MPQqbWDzkaYge/S5imT36JhPo0=;
        b=1mW3Fn1jMjKO1VsGVghUJ8bGJQiGcL8PKHhCaSJwN/AeyDLuyu+Ox2F2vpo+fGl05T
         Grs7rpyqIjmBPEdBE3/Kov8UtUDueG2gUX+N7Tr3dk/vxFJ732C797KRiclYyrf86vGy
         /aU1Vbs6pZe3iDeIkEvXc89A/ogfNwcP3K11RauChLhVgLQ6t+Gym7or68dGkdLC8NjY
         HNZuEphSnvHiMgaEs9ey3vmc13ECsKFscAlp+lTNtxnm3rXDJhpRx3RFP8RbQP6IeVew
         RVrlbgWnZss5uboNJxhGxRhDygxuQ5iWxk9Pg0hcwgVwXOcl5+iRfTDK5I6KPEAFzm/S
         6uFQ==
X-Gm-Message-State: AOAM532gjbTB+5ceotbaE+0dT6O3WQ+VZIgFLJSXONgDN8Hf53DzHN/6
        c9O9ywQm8+07YOd3y5mFlRv2VxOyLyVyVRxr5Q8=
X-Google-Smtp-Source: ABdhPJybmNBANFlN10q2IiFqD/V0UbYnzqQzIZ+YHuaRpWlMzbYu2j81lEWQvb4WQkqlwn26ACy/XYkZ5Q4wWI72FaQ=
X-Received: by 2002:a0c:ebca:: with SMTP id k10mr64698651qvq.51.1637239075630;
 Thu, 18 Nov 2021 04:37:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:f68d:0:0:0:0:0 with HTTP; Thu, 18 Nov 2021 04:37:55
 -0800 (PST)
Reply-To: UNCC-CH@outlook.com
From:   United Nations Compensation Commission <hamisuchizo59@gmail.com>
Date:   Thu, 18 Nov 2021 04:37:55 -0800
Message-ID: <CA+nAkfQR9hyhpg9UvA8GyDQT7XFcoNTmfcYjQgyX36PC8vMkkA@mail.gmail.com>
Subject: =?UTF-8?Q?Beg=C3=BCnstigter?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Achtung: Beg=C3=BCnstigter,

Dies ist das zweite Mal, dass wir Sie =C3=BCber die Statue Ihre
Entsch=C3=A4digungsfonds in H=C3=B6he von 5.500.000,00 =E2=82=AC (f=C3=BCnf=
 Millionen)
f=C3=BCnfhundertttt Euro) besteht. Bitte geh=C3=B6rt Sie uns, dass
wir von der UNCC autorisiert wurden, Ihre Entsch=C3=A4digungsgelder in H=C3=
=B6he
von =E2=82=AC 5.500.000,00 an Sie erfreugeben. F=C3=BCr Ihren eigenen Anspr=
uch
wenden Sie sich

Wir empfehlen Ihnen daher, sich an unseren Direktor der
Auslands=C3=BCberweisungsabteilung, MR Hartmut Wenner, zu wenden und ihn zu
bitten, Ihnen die Einzelheiten zur Beschaffung Ihres Geldes
mitzuteilen

Regisseur
MR Hartmut Wenner
E-MAIL: UNCC-CH@outlook.com
Entsch=C3=A4digungskommission der politischen Nationen
