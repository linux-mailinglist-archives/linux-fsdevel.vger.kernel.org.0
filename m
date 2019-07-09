Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7731762D16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 02:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGIAhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 20:37:52 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50284 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbfGIAhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:37:52 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x690boEi011204
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Jul 2019 20:37:50 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x690bj52001709
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Jul 2019 20:37:50 -0400
Received: by mail-qk1-f197.google.com with SMTP id n190so17937337qkd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 17:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=OjZRbgABpZBvMDOAUmYBmnCF4ZS/G+yWz40tVt9zM7o=;
        b=scw38JH8bmoVB48pYDdl+EcTqjuugPyuO7b8B5bMEaX8Qehui/dsmTGGAKfr4bEopg
         Y/IpvN52VFhU9rZqNq4L/cZIIIyLbRhJZvg5WmcBXvdhB791tKXF6lNRBxE4uFr17Ml+
         T1d+lFEYStpu55vm8yUX//xf0pg2Q+nfTUe5LLYNYonqNY/CJxhmoyut2ZrMiXvl75v5
         iveZVnUOAkXMso9pNePCPUhAn8yfgKKAaGWfqP1KWuWhjhRgUzNeNcxrGPgjA1v9ylQQ
         aCkrGCC87Er3FfDgoxb/oi81qWOAc49ryEszfOzUBWadWL0WZpPidriIYoq+4WJpXp2Z
         7OeQ==
X-Gm-Message-State: APjAAAV6tMWZ0N/e/3m775NSJTdDmigLwi212m0PXffcqcsOZmwUuw5Y
        AhLEry08FHN6Z6SRVNHK6re2tAvXt0gM1M8eI3qq3BjW5pJ3hTH1cibWdxOUftReer/RxuGARLv
        gbB2shJNh8n5BcGb7NY4TGFW/NSJwExMwQuFq
X-Received: by 2002:a37:6813:: with SMTP id d19mr16780990qkc.454.1562632665373;
        Mon, 08 Jul 2019 17:37:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbFEeUXsRnbhMMEq2850586hL282ux6U2bioRM0L8JU0Om9HCOlfHqXfOGUn65sn/AuySwJA==
X-Received: by 2002:a37:6813:: with SMTP id d19mr16780979qkc.454.1562632665165;
        Mon, 08 Jul 2019 17:37:45 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id z33sm6958980qtc.56.2019.07.08.17.37.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:37:43 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Procedure questions - new filesystem driver..
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562632662_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jul 2019 20:37:42 -0400
Message-ID: <21080.1562632662@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1562632662_2389P
Content-Type: text/plain; charset=us-ascii

I have an out-of-tree driver for the exfat file system that I beaten into shape
for upstreaming. The driver works, and passes sparse and checkpatch (except
for a number of line-too-long complaints).

Do you want this taken straight to the fs/ tree, or through drivers/staging?

--==_Exmh_1562632662_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSPh1gdmEQWDXROgAQJUtQ/+NuCpOp32phoMWYvnTb21fwNfIzCEPXBH
RSyAHXRkx17XhCx4jgTbz6FN95SGVNdlTuMF0GJPwHthtfdmHLql1QB2ROHELCjY
faIk6BGAuTnHlAExeC4VgMBUA+SBgfMwaVTs9d4i4yQ6+Uy8whEPcdgeuKecctFi
jt76tj+gRgpRIhTTAKq+DlpaIu/tpORttvGv23x/a8txU2Y0EaBRkcWbUVXWYI8G
IQ4Sk1J6T1J/n8trp/nHdG3vriAv/w+iUcjVFSDikSrp2tVG4OdbFUzsFC4P+wR4
7cuBLC4cgYZCX2tj45Tc9qTd6SpvdEozR/SQfW1r4lL1j0N05TZpcsYKzLibIegi
xWHpAMqSkhwfC2mF8c9ZCvq1wakHaTLN18OxKM/dPUKUxrSPPnvYiLoQsORH9pUK
JLXY2YlEwdY6SroUfZMBssL8MgGBx+dDcfimyJ1D6oZx1ss4wPRccuk6BmQYBzyH
hyYbNiKcPGimgZEwg2tVnn86X7FCcAhFza+UuzqJ37c0g4ldr/CYa2C0RXsPHn2x
eiKlV99LYR0SDugx8rs74s+bSi41Qi1GvSPy4zDWhBsCwwqxo1xFVAcndAk9NIVL
pKkzVh/nJIoAq724EW2C9dOtasEJx1ogOSUH48hNigytNyLhmOK/gVb9LO8A0vSn
fKUr0veoCZo=
=cgVZ
-----END PGP SIGNATURE-----

--==_Exmh_1562632662_2389P--
