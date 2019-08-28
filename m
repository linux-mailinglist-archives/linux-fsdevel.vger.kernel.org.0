Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B72A005A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 12:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1K7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 06:59:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1K7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:59:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id o3so850881plb.13;
        Wed, 28 Aug 2019 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=3PfQgtmB/PeAwXzGWu3d6xyhKveRxe5sV2Su3HbU17A=;
        b=EPTJU0js8l61hptAqP3s6hKS9aCaWQCN7ibiSNdE0YlenTrKIvMaJsnL00ZDyH/1Id
         HVjpQ8BxRVeJoMR7sXd8i/JICRFB0D615CJqg0mmYhS5NFUbNLc6AOnYQZhHqvb5tsfX
         GblMVaNIspx1j8Yr2R3D7tXDwmArQhhIJac7WuPlmLoPXveMQVakQQ1YCrui6Yj8B83O
         02s7Cw7xXknEuKTxMY7nAKHpg56M2d55t1SnI14IxCd8UkjAYdcOpGUCwa53rTVmCgoC
         tp6JYtulQCexCDDiG0UY0djuW7xN6WkBA2AmAZxVD1lo6KFWXbIe3CX16vId+io8PIfK
         XKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=3PfQgtmB/PeAwXzGWu3d6xyhKveRxe5sV2Su3HbU17A=;
        b=SAO+CMs2yQwiy282PxJGFqIrSi/44XRGgccAXENd/DnH7yf/agqZMBSJFxA3pMMAVu
         2J1vf+aZwv+UhGUFAkIyPguQCXfKmG1V53NZ0mRzFKwJdLw80IyVz5+RfJGuQKFpvA5L
         U/3tQxM8kTIdMyaGmy5XqeZpf9N1vpedJxu/D6Y3Nz2c582WsTbVZugU2liRh3pvN61W
         8mDI/QtQdFnJte5bOhKRt7fImRaO3iZdh2qkyQ5tRYICPdyGZunmY0Mr3Otwd8Kwvc4w
         Bjh4XN/5dCMoD4iaQ4bekzxPAOaXPAZ1v/Zr/Mr4jN6B4QIW3OyQpKKSCWyeA7oJB4Hv
         qocA==
X-Gm-Message-State: APjAAAUj+vamFhTPbDyDKPjDphr+JUfeZT6u/9viPP5m7lj8bQH3g+CX
        4r3FsR1BM4+y2kzyHPJRWm4=
X-Google-Smtp-Source: APXvYqwGf181xs50DmlZ+yXjcA3Ha+rq4NNQ+z03UQuBiE/tZSYbrDXwgyYFSdpeT6T3QIgucQmJpg==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr3671462pll.186.1566989940790;
        Wed, 28 Aug 2019 03:59:00 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
        by smtp.gmail.com with ESMTPSA id g8sm1969083pgk.1.2019.08.28.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:59:00 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:57:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] Disable compat cruft on ppc64le v2
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Breno Leitao <leitao@debian.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1566987936.git.msuchanek@suse.de>
In-Reply-To: <cover.1566987936.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566988993.aiyajovdx0.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek's on August 28, 2019 8:30 pm:
> With endian switch disabled by default the ppc64le compat supports
> ppc32le only which is something next to nobody has binaries for.
>=20
> Less code means less bugs so drop the compat stuff.

Interesting patches, thanks for looking into it. I don't know much
about compat and wrong endian userspaces. I think sys_switch_endian
is enabled though, it's just a strange fast endian swap thing that
has been disabled by default.

The first patches look pretty good. Maybe for the last one it could
become a selectable option?


> I am not particularly sure about the best way to resolve the llseek
> situation. I don't see anything in the syscal tables making it
> 32bit-only so I suppose it should be available on 64bit as well.

It's for 32-bit userspace only. Can we just get rid of it, or is
there some old broken 64-bit BE userspace that tries to call it?

Thanks,
Nick

=
