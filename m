Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11162030A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgFVH2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbgFVH2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:28:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8898FC061796
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 00:28:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so11932983qtg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+Uan9/0g2Kyk0+JFE+Gg6CPXTL0iWc6TM1qX4k9tCCI=;
        b=CEIoTrFcH9/ZEoLTpd6fmSkXQV5kJx6SiBea4C6+IwoO8z+Z1TfY40M/x2iObM6GCX
         Jy0tips3m8ok7iClqxkfuII3htkyFo2IDfNlN9BJlPhADjGd4YdrnLMXw4ktOca61LUM
         RgCJBX3fDwyzBWJfd0ozcaqZ6YmVWeYWWSAO3lq1tlxxaoTRw/zU38Dp0DN404aTxwyv
         2/LqaODnfkrI2Swvw8Goi9ZK+IAOUU1I/ISmwsOvUqZHpiTgD1Sh3Ynja398PQfCSD8T
         x/QO1WjXLd1y8S85tUcQSR8LZeMki8SEWYs+lZdo7Dp8DrHB218NllVMmIRo8KfQ7AwQ
         oOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+Uan9/0g2Kyk0+JFE+Gg6CPXTL0iWc6TM1qX4k9tCCI=;
        b=sWV+G/XCeqdHKweG/w1/3qunz1gJ0Zr1Yf1RgXje+jcqZe+QsQpUcYYhp1ujy29zPH
         KBv4nS4Tx5WWyFI0qkLBHD0ji8L7RQM0XMT9j1Nfilt5hbOlOPu1fV2Povpowrl2euf4
         ZuIEKm7n6sO2tr3bUnX74LFhgxP2vfAeUkYK3Csb/X5kWMqj+ikb/PdXttfoJPQ0UAlO
         l54myy7Aa/8SqefFmgvMnCeV2Qk4kC9ZlOO9DhrWPmAUGV2f2iGROiJxf1QlWJeeccqB
         n/Edst6y/m4CCDcdUxfAAMzVyGlJJ3I+ZQa2Z6m0qy1MivYbcG1okrWWIlqt41fGSYu/
         IrRw==
X-Gm-Message-State: AOAM531a8oZ/2PeXiQ+ifsaRZpjcecSQTfmSw5C3tDwIfDIsr6ezqa+8
        htRDbvHTRajAw3cu2IAYJKRCUQ==
X-Google-Smtp-Source: ABdhPJyWb4e97Z2/IMIqh2GpP+NVHRpesI9AkxGHkQn4/h3yxibqRZAvS1qnEvwYKJTYlHnAvtsp5w==
X-Received: by 2002:ac8:5307:: with SMTP id t7mr15073070qtn.229.1592810890652;
        Mon, 22 Jun 2020 00:28:10 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k20sm14406128qtu.16.2020.06.22.00.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:28:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
Date:   Mon, 22 Jun 2020 03:28:09 -0400
Message-Id: <121C0D57-C9E6-406B-A280-A67E773EA9D0@lca.pw>
References: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
Cc:     syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 22, 2020, at 2:42 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
> There is a reason, it's still important for us.
> But also it's not our strategy to deal with bugs by not testing
> configurations and closing eyes on bugs, right? If it's an official
> config in the kernel, it needs to be tested. If SLAB is in the state
> that we don't care about any bugs in it, then we need to drop it. It
> will automatically remove it from all testing systems out there. Or at
> least make it "depends on BROKEN" to slowly phase it out during
> several releases.

Do you mind sharing what=E2=80=99s your use cases with CONFIG_SLAB? The only=
 thing prevents it from being purged early is that it might perform better w=
ith a certain type of networking workloads where syzbot should have nothing t=
o gain from it.

I am more of thinking about the testing coverage that we could use for syzbo=
t to test SLUB instead of SLAB. Also, I have no objection for syzbot to test=
 SLAB, but then from my experience, you are probably on your own to debug fu=
rther with those testing failures. Until you are able to figure out the bugg=
y patch or patchset introduced the regression, I am afraid not many people w=
ould be able to spend much time on SLAB. The developers are pretty much alre=
ady half-hearted on it by only fixing SLAB here and there without runtime te=
sting it.=
