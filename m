Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6211F1D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 13:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfLNMcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Dec 2019 07:32:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40229 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNMcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Dec 2019 07:32:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id c93so1318677edf.7;
        Sat, 14 Dec 2019 04:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=og90X3T/HiK4QxMIRbjqxNLdYml1hZutaUaHYcrNOdw=;
        b=QCZd9EXGlipVlMW0kDuKPdpPvkgsN1s4JbXfvvVr+3x+6erztvQifDa7qZGsPBu0k7
         ihW84YNNf7LocFqHZAPJHTp9EP9srZacDWEyVaHg00hrt+8GqcRwBpQaaVIHbfgRFBGo
         v13Ly3U9V5dZx3Br4G8j5VkfpnQbwmKvr6ISxJY/QVK+Pkrd/SV6NA3abO7UK4z6OAZu
         gqX/X6jTxva8E5rCLYhYV+r9/EOMxOhG4T1umPtBKAsa2Zaeh+4f6rWPUg6bzqsGD8cr
         196IgCedfP2avhBsY0wkEMOVEhmIqS7YeKfYNkCIkRQlt0eb/gR3FS62fKYtTNFZlVCZ
         ORYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=og90X3T/HiK4QxMIRbjqxNLdYml1hZutaUaHYcrNOdw=;
        b=i8KreDG1N6O2Z8kpbOEiQ5cxvMug5Tr9B3RL7eqb9s1qkkWnLQxYLHMn+8DBwM1Fms
         cj+muFIEwNtetNq+6UMxYMKuGX9YFIOB+rWtHeU2LJLjhoWrzbHnBn2go0MIeTTBgOWt
         8H7y/8xfqxK3nQhz1vWE8oPBA8mi4vrecGoVaPqEbYga8M1Byevew5AxsiFynCy5Q17x
         YSTOSggy0fWzi1HVmPDrPhdEi8wPUjH3b3rumtzyN7yc7UIBs3o3r8YK2QYIPre+hE9U
         qmnZRivzGWgR7fawU68zq8Qi79lgMPgFnZ6ETlXeU0dTWQ9RcX64lfy3bulBqtjve1Ob
         SyHw==
X-Gm-Message-State: APjAAAVSNQTdzs+u8XIp1zb4I4Ipn0Xo24xnmIJI5y8mWq5qV1q6cLNZ
        rfYeku0pePpUUDopXhZXnWkms4EbpG4pym32gSw=
X-Google-Smtp-Source: APXvYqwuHKJGqjCUjTSlBZ/MqbcEF/B+Nq4qhfakyrLrsUlsSKfg/LkgUpDcIDkUw/NFY7w4go4mFqybCrF0Nzs7n1M=
X-Received: by 2002:a17:906:2281:: with SMTP id p1mr22619648eja.184.1576326757363;
 Sat, 14 Dec 2019 04:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20191107140304.8426-1-laurent@vivier.eu> <20191107140304.8426-2-laurent@vivier.eu>
 <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu> <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
 <1576267177.4060.4.camel@HansenPartnership.com> <3205e74b-71f1-14f4-b784-d878b3ef697f@vivier.eu>
In-Reply-To: <3205e74b-71f1-14f4-b784-d878b3ef697f@vivier.eu>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 14 Dec 2019 13:32:26 +0100
Message-ID: <CAKgNAkiaKJZMA0pzvwDa75CxfULTL1LmOZDzhW0Y5TmL7nBGZw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Henning Schild <henning.schild@siemens.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>, Jann Horn <jannh@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Laurent,

On Sat, 14 Dec 2019 at 12:35, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 13/12/2019 =C3=A0 20:59, James Bottomley a =C3=A9crit :
> > On Fri, 2019-12-13 at 18:51 +0100, Henning Schild wrote:
> >> Hi all,
> >>
> >> that is a very useful contribution, which will hopefully be
> >> considered.
> >
> > I'm technically the maintainer on the you touched it last you own it
> > basis, so if Christian's concerns get addressed I'll shepherd it
> > upstream.
>
> Thank you.
>
> I update this in the next days and re-send the patch.

Would you also be so kind as to craft a patch for the
user_namespaces(7) manual page describing the changes (sent to me,
linux-man@vger.kernel.org, and the other parties already in CC)?

If you do not have the time to familiarize yourself with groff/man
markup, a patch that uses plain text is fine; I can handle the
formatting.

Thanks,

Michael
--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
