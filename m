Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B84A5C76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfIBTAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 15:00:30 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45820 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726773AbfIBTA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:00:26 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x82J0P4m000668
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Sep 2019 15:00:25 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x82J0K09032712
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Sep 2019 15:00:25 -0400
Received: by mail-qk1-f198.google.com with SMTP id z2so16705163qkf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2019 12:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=X/y07lbPGXH7bB6jZdP7Y7cEHaqxYqjbURRNMPG/Hrw=;
        b=ZLSejQ+CSQlybKzLnEQjIuzQ2C6zsiqtmER3MJhIwQaaRdhWnFYdK5r7zqq1N/41Pv
         TK4ZLJrUJUvBMN40EtcnHtz4TKxy32EHLDqOfnYa6pVUFmHNJyakY6nOnTZHjXz4qpvX
         HeUxMhDGCH8EqW/0AElQ5qfO+Tyv/mfsBAckt44LnR0ocKcAn7SO2gZ0Xs5Ehy3XtQOq
         bawOA/mBFrJlre8NhyIMI6DAcz8KUNe6a2jo17VqOYgrYgKkhK+NqeNDkRDEMPWPQGkA
         oKL4wCqhxtKBnh/hKdwWZAVRhqSy3GAQoKiRgMDPZP6Y49/RFTS1+M94fVaXBfKyoZ3E
         TD/g==
X-Gm-Message-State: APjAAAVaRWHj1hZiB053z/owKU+FG3KahaDiPtJ/97TAAzmTzFrJ22C4
        BHY3tfeqmntcaN2cUd8icfbhGJGrnTKxyjbLgVNFdvp6Grw1TnTuo6E0heobg0hetxQ7svXw02c
        KIrPbnZeUg0CW5RH6D/IR5z+of+Sdi4B0zELf
X-Received: by 2002:a37:d2c6:: with SMTP id f189mr30717555qkj.231.1567450819901;
        Mon, 02 Sep 2019 12:00:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxma30y8CeByk3061faiFLcZAV2GhZK20oPOHS8T7CDWivXwHYnbWqBBq2P0PNalvAPJoaD+Q==
X-Received: by 2002:a37:d2c6:: with SMTP id f189mr30717531qkj.231.1567450819691;
        Mon, 02 Sep 2019 12:00:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id 22sm7364247qkc.90.2019.09.02.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 12:00:18 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190902152524.GA4964@kroah.com>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police> <20190902073525.GA18988@infradead.org>
 <20190902152524.GA4964@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567450817_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Sep 2019 15:00:17 -0400
Message-ID: <501797.1567450817@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567450817_4251P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Sep 2019 17:25:24 +0200, Greg Kroah-Hartman said:

> I dug up my old discussion with the current vfat maintainer and he said
> something to the affect of, "leave the existing code alone, make a new
> filesystem, I don't want anything to do with exfat".
>
> And I don't blame them, vfat is fine as-is and stable and shouldn't be
> touched for new things.
>
> We can keep non-vfat filesystems from being mounted with the exfat
> codebase, and make things simpler for everyone involved.

Ogawa:

Is this still your position, that you want exfat to be a separate module?

--==_Exmh_1567450817_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXW1mvwdmEQWDXROgAQIl4RAAo/gmznohIGbnQoiSqQRal12lVpZlEja5
QV7GuSKa9gPe0jd8ewra5/5HhEQINbocmI36jJeRxbkDWgBRvvxU7USO1FQRIDUE
aSkUC2kylgyQiq8guFyZTm8sgELLpDuJ2mOHK1FvaOdP4zIjfopiLWRPAhfyr1tw
vmB/AKDm9ze7wS+mu6dI8JROdOpNu0LoYGmD0TQtOIa+y8lJHmVNu7vRFo2+KeXi
LOLb1LDm9BaipSnco+apeGqEPx0AtlRbW7MHG03XOkQwgaq2lsGViBCpMkq5Nrmd
s/YIa/E6Z3YwLFEjzR2hCXZWZBrCk/waTUDS3psqkblP6K8MiBpCanSdutDw5/qD
33uxYgyGYWuTJYyLX2ziXby4/dPYoDU33m3ihu9e3jfcM/48a21r4LtDC2uTgKEw
O8bDWkpkZS1Sm5UiwpOps9cuNlmm+ES15rGFKId2hroxe8eGhswL5xkm3U9JGAGY
81qoAOm4Nisj+F19JlYtH84iHD4ZN0ic/TOXxjiB0tvitiilp+lAQyF4bE+7rzd9
J8zXqYCJF1JBB/dWF+N24E68ClU/A0CLtg6k3SVD0bNHt5Vn600xd7WqsGjDGUww
Da09AkmdVeNc+lX+pTYzDDe53bGqgJ4/g6XhoRsZijJWcH90+fpKODQeGdydqL71
ZJLR8r8Chhk=
=CHbf
-----END PGP SIGNATURE-----

--==_Exmh_1567450817_4251P--
