Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2092A2449BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHNM3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 08:29:06 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:35857 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbgHNM3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:29:06 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 3D99D821D8;
        Fri, 14 Aug 2020 15:29:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1597408142;
        bh=Iw6Y6XZXPaiabTVuM/0vS3/cljuK3vSfRRU2EX8bVMA=;
        h=From:To:Subject:Date;
        b=lA4Z5YPwe9WgHrXODDC1MVvwajy2Beq5KfP5h5nZ6Ic3w9SzPTCoqju4YHY6IcNaK
         +WSjEDAnOkZthBRFZjKL+9b01hwp2y3bHRpX44PWfuO10S0z6POKSd8IrH/ADRHXuZ
         adlLVt2OItXOMaN0v7Ocb0WAPcJ1t1mgB7YcH7hY=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 14 Aug 2020 15:29:01 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 14 Aug 2020 15:29:01 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Index: AdZyNcmjSkpkGje7R9K6YobJrVDyZw==
Date:   Fri, 14 Aug 2020 12:29:01 +0000
Message-ID: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds NTFS Read-Write driver to fs/ntfs3.

Having decades of expertise in commercial file systems development and huge
test coverage, we at Paragon Software GmbH want to make our contribution to
the Open Source Community by providing implementation of NTFS Read-Write
driver for the Linux Kernel.

This is fully functional NTFS Read-Write driver. Current version works with
NTFS(including v3.1) normal/compressed/sparse files and supports journal re=
playing.

We plan to support this version after the codebase once merged, and add new
features and fix bugs. For example, full journaling support over JBD will b=
e
added in later updates.

The patch is too big to handle it within an e-mail body, so it is available=
 to download=20
on our server: https://dl.paragon-software.com/ntfs3/ntfs3.patch

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
