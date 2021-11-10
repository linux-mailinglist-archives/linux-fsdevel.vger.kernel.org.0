Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66EA44BAAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 04:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhKJDqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 22:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:46:39 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF7C061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 19:43:52 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t127so613651vke.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=69+CcKPoLS4i+mYXgdI74TAOw7gAaKsz88pklWx7JaM=;
        b=gkU0rkaZYgIbVfyW71OBh5pfU8ULjgruDRuUdKCr5+hshUFpvSF9d151QdJUqBxyP1
         oBrBlM091lNkpnWJqnOFxn2o2Z9XtvNmPc0xPpF7Ya80LVl/5ZxBmkUD0nykzSCECFv7
         Eytok7ckk8PNCRCZNr1uLXOJj5lvH2VsgAMRqw2LDU7oBdqxj1ogODPFvMuFe+M4oWko
         RlQp1CxJtY0k0TgEjkYD+rmnKCwjosuIdP0Jg35Hbzw9i5MoUmVeqeyw/oaC7WQ14h2f
         9Xq674wehGw3xC2vAcpy5HD8h9tYOeDSP8oDcdkE+4rxE5UUHNaBbkLl+t5IfeszgXXH
         LXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=69+CcKPoLS4i+mYXgdI74TAOw7gAaKsz88pklWx7JaM=;
        b=mQVedj9cAApzx5KnjwqBtt32TxVYz44kbygvsHZQBuW5Ik1apB2gmTd7aw6pHeECMo
         TbUIHaaVzHIW3qa17uOVUDrmlAji+9HHSyBbZqVtUdt6sSh2U0Zj/1TuagEfRMCmIOt8
         n9Z6vIRNtLk2xkal8zFwr7pQDnAncZaCFpB8fDOKPlaPNDlGMCb85U1Lo6wuj6zYnQsJ
         yKRqKCk3WfWXH4s85Z4SEPsi1RGv9cLH1gNs3ty0WrZFo+jwuh+x5mJJyinXEhvDeOGW
         LT6KYUt4UtZaHO/w5NwVNhJFLB8Tgz8EhBqjBjXuvyHYKJwc1BHwBLF+47Xe3Pv8PiSb
         ddSg==
X-Gm-Message-State: AOAM53206TXOLa/IUYL9NqZtjeisRJmzmUdKUaP2xjmOfwa7C0PllyYa
        gE+1EpCAKtal330Z8xtF6f6ZmFR6MTMRiS8noaivtHXZYZig3g==
X-Google-Smtp-Source: ABdhPJw0GPR6noieKRXvgI+jSsiQfMgIU+cG2VWrK71vJAXpYrdXM7ZdY03o5idIpPZINxyP/TDhLb9J6B4wTYW2SS8=
X-Received: by 2002:a1f:5685:: with SMTP id k127mr18808126vkb.7.1636515830652;
 Tue, 09 Nov 2021 19:43:50 -0800 (PST)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
 <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
 <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com> <CAPm50aLPuqZoP+eSAGKOo+8DjKFR5akWUhTg=WFp11vLiC=HOA@mail.gmail.com>
In-Reply-To: <CAPm50aLPuqZoP+eSAGKOo+8DjKFR5akWUhTg=WFp11vLiC=HOA@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 10 Nov 2021 11:43:15 +0800
Message-ID: <CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJdRuwxawUDA4jnJg=Fg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 5:27 PM Hao Peng <flyingpenghao@gmail.com> wrote:
>
> On Wed, Sep 8, 2021 at 5:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 8 Sept 2021 at 04:25, Hao Peng <flyingpenghao@gmail.com> wrote:
> > >
> > > On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu> wro=
te:
> > > >
> > > > On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> wr=
ote:
> > > > >
> > > > > For a simple read-only file system, as long as the connection
> > > > > is not broken, the recovery of the user-mode read-only file
> > > > > system can be realized by putting the request of the processing
> > > > > list back into the pending list.
> > > >
> > > > Thanks for the patch.
> > > >
> > > > Do you have example userspace code for this?
> > > >
> > > Under development. When the fuse user-mode file system process is abn=
ormal,
> > > the process does not terminate (/dev/fuse will not be closed), enter
> > > the reset procedure,
> > > and will not open /dev/fuse again during the reinitialization.
> > > Of course, this can only solve part of the abnormal problem.
> >
> > Yes, that's what I'm mainly worried about.   Replaying the few
> > currently pending requests is easy, but does that really help in real
> > situations?
> >
> > Much more information is needed about what you are trying to achieve
> > and how, as well as a working userspace implementation to be able to
> > judge this patch.
> >
> I will provide a simple example in a few days. The effect achieved is tha=
t the
> user process will not perceive the abnormal restart of the read-only file=
 system
> process based on fuse.
>
> > Thanks,
> > Miklos
Hi=EF=BC=8CI have implemented a small test program to illustrate this new f=
eature.
After downloading and compiling from
https://github.com/flying-122/libfuse/tree/flying
#gcc -o testfile testfile.c -D_GNU_SOURCE
#./example/passthrough_ll -o debug -s  /mnt3
#./testfile (on another console)
#ps aux | grep pass
#root       34889  0.0  0.0   8848   864 pts/2    S+   13:10   0:00
./example/passthrough_ll -o debug -s /mnt3
#root       34896  0.0  0.0   9880   128 pts/2    S+   13:10   0:00
./example/passthrough_ll -o debug -s /mnt3
#root       34913  0.0  0.0  12112  1060 pts/1    S+   13:10   0:00
grep --color=3Dauto pass
// kill child process
#kill 34896
You will see that ./testfile continues to execute without noticing the
abnormal restart of the fuse file system.
Thanks.
