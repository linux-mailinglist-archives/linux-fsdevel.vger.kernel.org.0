Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA272B0278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKLKDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 05:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLKDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:03:32 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C75C0613D1;
        Thu, 12 Nov 2020 02:03:32 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n15so5019958otl.8;
        Thu, 12 Nov 2020 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQZyFP+icQ6Gn+nIuSyMic/jsZR6XqrBTW4Q4kxWbsc=;
        b=ta+ZqYqNIy9QGI0x10rsJEncrpVQ1T2zSQKnOUL7XSKQ3ge+yq7y70/fHmgJ4ix1ek
         DD7qGiiv4+8NTvbCfXlfTKUEcUrYFOenButeYWUcClxi54CvqFfJXHdmtGqVp7P+8RvF
         pTDzp57IVEQDqeI8f6GiFCDuRzNVBMVaoV++VGtTjm8yM5TKNdVFq0kCPdLWAVVosuZ+
         dxOmJmhltDVrEz6/h8Ui5Yj5sp9C7coAA/hrvU55xgDlqwFnzx9521SN1Oa8Za7oBRvK
         aLqczMJfeF0E/EHvHYjYHZHJn/038E+kdW42Shf1JyljgiyLs0SpHTsmDJb+pyT5VJR2
         eDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQZyFP+icQ6Gn+nIuSyMic/jsZR6XqrBTW4Q4kxWbsc=;
        b=ouPchq5eBV6vzaWvy1Y5rxANt9sn5dnwrgVD3jIAy8HsdJR0gzgdbhtWVOrpZk6Sgd
         fEUMn0/9E17XnqhMFksTCyKrXf67L0cJ6K2LotfcWftkAxVPFIroVybcBCBdL5Ygztn4
         rhKsEEenBN3N14YNkNDDKDathmi4rlS80vfczjP25nIK6XcxMNdqH/pHIHJ54RZULK+7
         HUd+6XSNzTtDAhe4aJsX/m8VbpSq+9+tz+0gfiqB7tVX19vaWN3NQaCP+lqYz6tctKdX
         NaFMPUabW6vx99Xy4nR6PYtkRUDrml+cXJm2IHjs9DO41t1AB8IvFn3OKB1VukDb1tJn
         hYNg==
X-Gm-Message-State: AOAM532hVN8VE+g4Pfyp3PEqz/Pg+R6pMeRzlGodRBJnsnq5P4CCEmcO
        5sXzEycPOKNNSb6KOFb8xGrSY0NdHW3FrO9m58puGc4O
X-Google-Smtp-Source: ABdhPJwF+g7BGINLx5YfFrAql9wFqg+kDoGOXoeW7JztQPV3niNCwoEjwDHQ8ldgk6hAr+rNnEN+atz+PjlXneaw/o0=
X-Received: by 2002:a9d:12ab:: with SMTP id g40mr21957319otg.369.1605175411617;
 Thu, 12 Nov 2020 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
 <20201110200411.GU3576660@ZenIV.linux.org.uk> <CACZOiM1L2W+neaF-rd=k9cJTnQfNBLx2k9GLZydYuQiJqr=iXg@mail.gmail.com>
 <20201111230908.GC3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201111230908.GC3576660@ZenIV.linux.org.uk>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Thu, 12 Nov 2020 18:03:20 +0800
Message-ID: <CACZOiM0SH_Uo9F5jOGtpXSnkHarH=E-BA-7eUFFKsb2onP2yOw@mail.gmail.com>
Subject: Re: [PATCH 01/35] fs: introduce dmemfs module
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 7:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Nov 11, 2020 at 04:53:00PM +0800, yulei zhang wrote:
>
> > > ... same here, seeing that you only call that thing from the next two functions
> > > and you do *not* provide ->mknod() as a method (unsurprisingly - what would
> > > device nodes do there?)
> > >
> >
> > Thanks for pointing this out. we may need support the mknod method, otherwise
> > the dev is redundant  and need to be removed.
>
> I'd suggest turning that into (static) __create_file(....) with
>
> static int dmemfs_create(struct inode *dir, struct dentry *dentry,
>                          umode_t mode, bool excl)
> {
>         return __create_file(dir, dentry, mode | S_IFREG);
> }
>
> static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
>                          umode_t mode)
> {
>         return __create_file(dir, dentry, mode | S_IFDIR);
> }
>
> (i.e. even inc_nlink() of parent folded into that).
>
> [snip]
>
> > Yes, we seperate the full implementation for dmemfs_file_mmap into
> > patch 05/35, it
> > will assign the interfaces to handle the page fault.
>
> It would be less confusing to move the introduction of ->mmap() to that patch,
> then.

Thanks for the suggestion. will refactor the patches accordingly.
