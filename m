Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041CDA4CAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfIAXOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 19:14:04 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52856 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbfIAXOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 19:14:04 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x81NE2ZY019691
        for <linux-fsdevel@vger.kernel.org>; Sun, 1 Sep 2019 19:14:02 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x81NDv8O008408
        for <linux-fsdevel@vger.kernel.org>; Sun, 1 Sep 2019 19:14:02 -0400
Received: by mail-qt1-f199.google.com with SMTP id o34so12523657qtf.22
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2019 16:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=qgYkPX+GTgX0rONC/65E9DiuSKcDLCwYEWFWrUp3ruo=;
        b=bVvca4Yy3J39JxuvOXEnz5lXKErWu8s4opKbl5mNTiH5Kt/aFgXKYKIAIbISdNbkCh
         dlJAiWp0IOR3ZLpGrL4cPeSk/lpHdFTMPGNuaiYsYwFbmvrlY8jx8R5AgsyMt7k9SAuI
         JGpiat/U2VueYUK2qf9wle96kqGVz6IRk2NjLBrupBzKwv2lS+hNZ316r6DTbC7B0AZo
         RKwi/UoRaXnaMLNK4Nml2VH+mqgkqUI0nrOdtaP/mwvbr6HGDJBqDSUkljE+Yla6j5qe
         41r3TV5ysmZyotNPwGtbOKt+g4WCtIaIMDNHL/WGx4IjURMsN26GO6sGBNf3q0l8B+Fi
         wWXw==
X-Gm-Message-State: APjAAAVb475jBL8k6veKK2RsVmLIE76cbAvCHsvmP4FlcwByCv2NnYY+
        GofqdcRe4ZNH3ZVk+j7yMrQgliXCdTKsZg+RtVUalFgixRA+EPMh+xzERzInuL/pF3Z1qyx+cL0
        ifvvbvPG7r3H4ij6kUGLWIUAIh3OoBFVsjgzQ
X-Received: by 2002:ac8:4787:: with SMTP id k7mr8209629qtq.58.1567379637360;
        Sun, 01 Sep 2019 16:13:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyunIhRucdRAhnWWiCsn7LEaA3Hw9XKbWjoYwW0GfwgecsORPB15PIaonHnEYoXVhnjx0eMbQ==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr8209612qtq.58.1567379637096;
        Sun, 01 Sep 2019 16:13:57 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id o124sm5601412qke.66.2019.09.01.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:13:55 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190901224329.GH7777@dread.disaster.area>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police> <20190901010721.GG7777@dread.disaster.area> <339527.1567309047@turing-police>
 <20190901224329.GH7777@dread.disaster.area>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567379634_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Sep 2019 19:13:54 -0400
Message-ID: <389078.1567379634@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567379634_4251P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Sep 2019 08:43:29 +1000, Dave Chinner said:

> I don't know the details of the exfat spec or the code to know what
> the best approach is. I've worked fairly closely with Christoph for
> more than a decade - you need to think about what he says rather
> than /how he says it/ because there's a lot of thought and knowledge
> behind his reasoning. Hence if I were implementing exfat and
> Christoph was saying "throw it away and extend fs/fat"
> then that's what I'd be doing.

Again, I'm not ruling that out if that's the consensus direction. After all,
the goal is to merge a working driver - and for that, I need to produce
something that the file system maintainers will be willing to merge, which
means doing it in a way they want it...

Hopefully next week a few other people will weigh in with what they prefer as
far as approach goes.  Only definite statement I've heard so far was
Christoph's...

> and we don't want more. Implementing exfat on top of fs/fat kills
> two birds with one stone - it modernises the fs/fat code base and
> brings new functionality that will have more developers interested
> in maintaining it over the long term.

Any recommendations on how to approach that?   Clone the current fs/fat code
and develop on top of that, or create a branch of it and on occasion do the
merging needed to track further fs/fat development?

Mostly asking for workflow suggestions - what's known to work well for this
sort of situation, where we know we won't be merging until we have several
thousand lines of new code?  And any "don't do <this> or you'll regret it
later" advice is also appreciated. :)


--==_Exmh_1567379634_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWxQsgdmEQWDXROgAQIEChAAkp7n5MxBSc3LAt80yIYEqpOUllyAzLk+
se7lfnDiTSO/4D9ByufM6MDCfpGMCXn09h1yO/iltQ2gZZ0DfQuQdTIL1579v9u6
/fFvMnxcRmILRQt8rJw1arjPJcWHUjO97HcFh1e3rA7d7Om3I3fU9nwd/OVrZfiS
/GiSLHrBtRGvir/YJsiTIb6Sguv7TB+sKKekUVOCmT2h/zsLC1ElOnW0MiL8R8bq
ROT4IkyBZQFanoRLC9aQbDqGVl+wn7QRGXHXpsvixEG4pyj9oxHFpMBvXOOC2fTU
fElyh8gjzIJ2H6ZW6anGgTpY+W0ZnzZDMXfVBP+6uEmrfPQ/oWB2GUzpaiXeB7hb
su6eaJcACwm5Tza8mwwIoCNjhP6Bg+dDOuCneeAKon9/FTl2d2/u5cUNoj5+rWSI
9xZf1Anxv5BsOwunzkWIH5lcni8X/Wbm2bBWU4BDOQYooFiLaLlwfWxHtj9UGBGC
AN3HzUW/p4Uc4NsSwFQ67VgZWTMEvmfG4x6IRIZOY27lDlJoZBV86Cw7VXdQ0HLq
1w5k91HR9gslP4/qYsecH45VpvbjIakTC+eehE5iTtkJyZBkvEK7E6OOBdQemVM9
QMg7V7IQJV9+3VLnaItG07kxZPijXGNeB4i76Sj4cz5otcGhMSjFPxNzfQ1ycTwF
E9Vtf9AVaoE=
=JCXU
-----END PGP SIGNATURE-----

--==_Exmh_1567379634_4251P--
