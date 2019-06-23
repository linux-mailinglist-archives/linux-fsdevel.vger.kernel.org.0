Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6907D4FF73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 04:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFXCgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 22:36:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42002 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFXCgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:36:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id x144so1367103lfa.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2019 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
        b=XRzekx12x2R8BEza9NPZGwIGOrPwswPbQRhDWoOLF3Yfpx/jrUbZUbgCDaQ1lWFtcc
         3S8GL5iLJsMPb0EPOjtDLGuDxfLsEUbaCwp8/WB72LPvX/Fv0JqSqU1xsxhmqvu54VR+
         oO21ddEIYT5zCq2CRR74hE5nz4XimDWYTnIgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
        b=pO1dPLBkMCMqXKevcUp08uHr+tnuPB0QI0iMpASYRgxPpuPa+rkI4oNhmEuzvlcDb1
         +KH2MC/7K0vUoayIA4I68SdPVHrURKmAW+phCipqEHWI2holq9rwUR0e8o9lvXoiZ47V
         0qnNvIj1L4a5kow46xd315WsxHMHjZ8eAPcu4R586OYzUsibmr96NUWv3R/LUZ+xDzfM
         r1/jD5QoyjG3BVSK6JKGu6rjLxDFU7EqkWRkS0+dN+b6J8hgQbAVxEqlINPzgwBGNqAi
         CWGf9kHPVodX1JJEnIdykhbDjGixImEeH7tQ4r8YDBR4L1AfweG/zDtRiUGfL9yqGQy6
         8rdw==
X-Gm-Message-State: APjAAAWnm9BX6SoL1v7rzmpwz5lrqVWiKlxqSgBFjBflx9sUt9DyrPCu
        tIiBC0qNOjcUYvGU6VTva6kGVJWuTSFiCN9vp1i9kXuwugI=
X-Google-Smtp-Source: APXvYqw5GB8w+Rr7ZCSldCfQW9Z++tyCAuBFim39MNoH6h0Nz9D6axObPB4rzu6i0my/bgVMZFoWONlA3soFypmx88s=
X-Received: by 2002:a19:230f:: with SMTP id j15mr35109270lfj.122.1561327778613;
 Sun, 23 Jun 2019 15:09:38 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Swanson <swanson@eng.ucsd.edu>
Date:   Sun, 23 Jun 2019 15:09:27 -0700
Message-ID: <CABjYnA7JXEwoxyE+2QisupAQuG0YJ3GUY24QooqY3vAZoFZOLg@mail.gmail.com>
Subject: Call for participation: Persistent Programming In Real Life
To:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You are invited to attend the first annual Persistent Programming in
Real Life (PIRL) meeting (https://pirl.nvsl.io/).  PIRL brings
together software development leaders interested in learning about
programming methodologies for persistent memories (e.g. NVDIMMs,
Optane DC) and sharing their experiences with others.  This is a
meeting for developer project leads on the front lines of persistent
programming, not sales, marketing, or non-technical management.

PIRL features a program of 18 presentations and 5 keynotes from
industry-leading developers who have built real systems using
persistent memory.  They will share what they have done (and want to
do) with persistent memory, what worked, what didn=E2=80=99t, what was hard=
,
what was easy, what was surprising, and what they learned.

This year=E2=80=99s keynote presentations will be:

* Pratap Subrahmanyam (Vmware): Programming Persistent Memory In A
Virtualized Environment Using Golang
* Zuoyu Tao (Oracle): Exadata With Persistent Memory =E2=80=93 An Epic Jour=
ney
* Dan Williams (Intel Corporation): The 3rd Rail Of Linux Filesystems:
A Survival Story
* Stephen Bates (Eideticom): Successfully Deploying Persistent Memory
And Acceleration Via Compute Express Link
* Scott Miller (Dreamworks): Persistent Memory In Feature Animation Product=
ion

Other speakers include engineers from NetApp, Lawrence Livermore
National Laboratory, Oracle, Sandia National Labs, Intel, SAP, Redhat,
and universities from around the world.  Full Details are available at
the PIRL Website: https://pirl.nvsl.io/.

PIRL will be held on the University of California, San Diego campus at
Scripps Forum, a state-of-the-art conference facility just a few
meters from the beach.

PIRL is small.  We are limiting attendance this year to under 100
people, including speakers.  There will be lots of time for informal
discussion and networking. Early registration ends July 10th.

If you have any questions, please contact Steven Swanson (swanson@cs.ucsd.e=
du).

Organizing Committee

Steven Swanson (UCSD) Jim Fister (SNIA) Andy Rudoff (Intel) Jishen
Zhao (UCSD) Joe Izraelevitz (UCSD)
