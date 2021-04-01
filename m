Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBF3512F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhDAKAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDAKAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:00:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49225C0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 03:00:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j3so1253998edp.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAMcIYZQsWcLNDtTVmIuYET3cf4HAVlQE3VpsQIkNFk=;
        b=K+JVGvthsrNFu3mE27IZDp1ESdXD/DH8MV7fVfp0PrJRvTaQPDlS7Mx2JPSiYc/eVb
         IMiERYEuPH10MeER5t3ZIlAP5s3GiqAsco5xGXPHwH2Iaa4o1zaWXaFdBJyka0Qx0GP6
         RJ6hKulxjcqO5zQRIOaUiBey0u4YWlW+7YwIpZRRj8jj2yZfBBRuMLs/yekuO/wlvn+Z
         oPQA4F/+XWiRuzXrUyUEKOu6ZkqMS60ZALR/DB2WQC/BMlwr/AC9ingCl+4J6z7dYelN
         IgFgfLUYAmG34lpJfoN0bUwvoUW0LJP7R76ICpfh+J8NKWfAgVtbIG2jtPGND8wPOTkw
         NvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAMcIYZQsWcLNDtTVmIuYET3cf4HAVlQE3VpsQIkNFk=;
        b=DMhvPJNxANXBgFuWP7cTlwNaH2+L0qmzCb4cbiR/CnR5tjUYzc9+X3Xep1h67D+sij
         oLF6gY4SZEM2uiwWkk19gSKF80T3aiFfdHCeio2nhmhMYh3OSojPmjksvTHe1oiST4dD
         ZKwFb64ecTQIKolKRLPzIu7WF9Fqpg6R7bLFaoARyql4aVlKlp8DgTj5mVpcKT3t6QkE
         5vCCq8wtn/Z3QazU15i4RQjwS+1JGWR4ai/DM8YrXiPaQnGLoXD9nm2NItZWUr1ICRa8
         VEw3zl4z/9A5+EstwFKszL0uM2IzOYlFNAC0jWR9b//LQkYfsSqMKy26QdAkQYTv7uFQ
         2roQ==
X-Gm-Message-State: AOAM530nq5By/vR6IvDgUdX/xv1uSP8Ofvpha6gOEbRzMEzMg+H5wvSN
        crHsXMqYahZ2AzconadR3EszFVEBWVVBFCSXFKms
X-Google-Smtp-Source: ABdhPJx+A7HSBREZzbKfoV5/V2Ydyp7kDa8oOncSc6SF+/vwx9FyveUcECoT66xXAwNgEH1ZBs77kIiOwQS9fCCP/MA=
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr8941753edy.312.1617271239083;
 Thu, 01 Apr 2021 03:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <YGWYDog+YhgeD1mS@kroah.com>
In-Reply-To: <YGWYDog+YhgeD1mS@kroah.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 18:00:28 +0800
Message-ID: <CACycT3vK_99-AVCf_U7AACGif90xPWxvAo94-tU-LKYh0r9A3g@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] Export receive_fd() to modules and do some cleanups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        viro@zeniv.linux.org.uk, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jason Wang <jasowang@redhat.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 5:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 01, 2021 at 05:09:30PM +0800, Xie Yongji wrote:
> > This series starts from Christian's comments on the series[1].
> > We'd like to export receive_fd() which can not only be used by
> > our module in the series[1] but also allow further cleanups
> > like patch 2 does.
>
> But binder can not be a module, so why do you need this?
>

Oh, right. I miss it.

Thanks,
Yongji
