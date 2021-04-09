Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8800C35A2A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDIQHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIQHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:07:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AEC061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 09:06:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id n4so5112741ili.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCbjbR89bYo1wK4UCkJv2P1iHuZdY6ZoBkGIARn0nT4=;
        b=LIgvLC1aTCkDTgS72fDeO1jVMHK3SL1uMjpX7H//4kUe0VLwwvPuPYLuFyQWmeiy3E
         U6pHA6VMMyzfn1EyrzBXP/vDSzJ89MOpAtx6XDj9is2uynprzB8YzxGMzlE0yNLlFIbK
         iVxu9csPq/Sepx4oHpB21Cq1a0JZY7U/dL4zl2Xh1sSQR+ruwoH7Y8CDSOyeysLk68ID
         UPzurIJ71CII5zYnujBijDEGCanCDXP0L+1yJcVWL0Z++V8U/H+trCA9JbM8+5/mmxnf
         R8FhHfpNJ7zs8Cmz2b7DmZefyjJXcCd1/tC4/ATCIQRRWPiEg8D8nvBW0fDQKNIMGCfG
         kdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCbjbR89bYo1wK4UCkJv2P1iHuZdY6ZoBkGIARn0nT4=;
        b=EWbpVmvuAOEcv0XKWIA3xV9CqO0JhZRn0wYk2DxN+2ms6ak9PMbnkCB5l+QjBmgU01
         D06XOwsISdpW8dp66zIVNzkgjMC/jdbrORJAvR5TF1VUDfOI4sdIeGSpfKtP288MT6Sh
         f9wRjTgUzgOFxrwRKkowMkGGcVAiDQSFSiRXItzz/yO4RU2w8A+QUBd41PfW30/hkDSo
         dyfiszwV/g1mmmvflFQ+RygL81zoqaZYtzqjevNUXGrp+6YUgef1tfbn4B7IWTx4bHep
         umgdLSDq/rOehDCgNeZOZ2k9HaR7zoeZ7KfzXhOXznmlHuaY6sygTzbAxMV2KD84NaXV
         rm8A==
X-Gm-Message-State: AOAM533m9rCevA2XAll8Wu1DspL+7F1ieqohhudn6OCcPXfmFboO0lf9
        fQVkvw3Z2OGFl5Af2+9QEkJHW6SsO3iAs1jLmtY=
X-Google-Smtp-Source: ABdhPJzz8acFv/BKMOgIArCzldfSGTDjIbI08qcOhmRB6/2vD8zeAbrbg/ImXhGm2az9bdRZF5GF6Za7E8iqcPaWvTY=
X-Received: by 2002:a92:d44c:: with SMTP id r12mr12210110ilm.275.1617984414295;
 Fri, 09 Apr 2021 09:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz> <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
 <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
In-Reply-To: <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Apr 2021 19:06:43 +0300
Message-ID: <CAOQ4uxi-UhF=6eaxhybvdBX-L5qYx_uEuu-eCiiUzJPvz2U8aw@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 9, 2021 at 5:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Apr 09, 2021 at 04:22:58PM +0300, Amir Goldstein wrote:
>
> > But we are actually going in cycles around the solution that we all want,
> > but fear of rejection. It's time to try and solicit direct feedback from Al.
> >
> > Al,
> >
> > would you be ok with passing mnt arg to vfs_create() and friends,
> > so that we can pass that to fsnotify_create() (and friends) in order to
> > be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?
>
> I would very much prefer to avoid going that way.

OK, so I will go with the more "expressive" implementation that Jan suggested.

Callers that do NOT care about mount mark semantics will use the
wrapper:

vfs_create_notify(mnt, ...)
{
    vfs_create(...
    fsnotify_create(NULL,...
}

The two callers that do care about mount mark semantics (syscalls
and nfsd) will open code:

vfs_create(...
fsnotify_create(mnt,...

Hope that way works better for you.

Thanks,
Amir.
