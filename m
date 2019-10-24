Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9175DE37D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407492AbfJXQ15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:27:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56944 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405273AbfJXQ15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:27:57 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGRtpl029166
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:27:55 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGRoBv003150
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:27:55 -0400
Received: by mail-qk1-f197.google.com with SMTP id n17so6548344qkg.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 09:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=bsN59ZY0yNzgZCIBp0VQtgU1UUq95H4MJw3f/UhzjmQ=;
        b=pNYTQyjsviVAVnxMJUTFFt6Kl95dSIa31gV868PQ1ltEb3xIfG5Xnh8qrR0Gj5Sxm7
         uHPnGzymG0D3TqHPvkIIFBw8avtr6e8/0RXj08DCRVD1IZOzJq1yrLzD2lsjBT25tbKu
         uMyEQaOyFR5pC9Sc1LiTplXqKgHzsYeHb1YFa8II07GZT02JuSb0XUPjzkHF8G3l1bIw
         If44DtvcJUPVL4QZURQa8j8kcMzpCCD/alDldnKY+snyL3wNxr1nPel8lAhPnfvtwILw
         watgQwtcONTL8vuozLjv4/7QxhZVRhQVVMS4/fHLsewOxrvyJAa9VpYcXoPLGrDCKWAp
         cUjw==
X-Gm-Message-State: APjAAAUpWx+I2dQ/OD1pUbcToH6eMhOfn2cTZnN6J2SXMipOxAYAu9Uk
        cA0fReWumm5KklS/4sVQJRuudw5TKC5VnsRw3G2j5Bn5EkBYC9sgFHU5hSujeLlPCZji/rGwcYJ
        /SK2F6swRuPX/Dc6gelrmM+kZo3Bn/lrA9qlG
X-Received: by 2002:a0c:92dc:: with SMTP id c28mr15714522qvc.26.1571934470603;
        Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkQAmcVf+6706DClmV4SjT0O16B06ZuqsaMrMGTqHXVbTS3u02dKBqi7McVkGiv/fbSgjmkQ==
X-Received: by 2002:a0c:92dc:: with SMTP id c28mr15714469qvc.26.1571934470085;
        Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d126sm10733461qkc.93.2019.10.24.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:27:48 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: exfat: Clean up return codes - FFS_PERMISSIONERR
In-Reply-To: <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu> <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
 <915cd2a3ee58222b63c14f9f1819a0aa0b379a4f.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571934467_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:27:47 -0400
Message-ID: <1107916.1571934467@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1571934467_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:23:33 -0700, Joe Perches said:
> On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:

> >  	if (err) {
> > -		if (err == FFS_PERMISSIONERR)
> > +		if (err == -EPERM)
> >  			err = -EPERM;
> >  		else if (err == FFS_INVALIDPATH)
> >  			err = -EINVAL;
>
> These test and assign to same value blocks look kinda silly.

One patch, one thing.  Those are getting cleaned up in a subsequent patch.:)

--==_Exmh_1571934467_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHRAgdmEQWDXROgAQLonRAAgmgi1IyWgKM8Z+fUANqetKRbDPtKzie3
y57H8MYZukD2LXLVrzSbZAZxEZzOr5/UXll3daYEWN6FH2nmXBpmMZO9La7jFEll
m7wEEG0ET6g03Kke3ZYyEFntLjnFEhmYxk2lWy03zFpJQ292BU+TmH0AFob8S5Xg
M665oOaEB6Biv+4jJ5+cgBGDyiDgxED6G6qLStbLC2lbERJ3jfoDuR2WegOA6zu5
ZTGY2/fWCJ/ejYfVF5rM7mTlg0FQD+9xYHgNRZdRg2YsNDhk5Osnisols8OVk3im
H0Y5xsBgzhtZljIlwk1PI/IlWIGn/f3dgNH9LTdsXxm4aKE76VUFnZAk1/y2wMRP
ZXieXPr8D9VvSLD5YpINE1hkBRNb/fVbm0zpiSnWN/U4jNtvAYAeFrEfhOiDc+Dn
VCKBiOmUrrb0AkaZJt5D6+BgEZFnYaO1hHUqkL83R8QAK6d+azSTgVVvHDNc4Fif
iTt/pKW7kN6YP+M6pi07uZI7uEzGsGwSrigiJXE+nOv0xe/BbeDGSDMO4Env3Wym
laF62431/LAMsQxv7SJ1+i64AI1vLcOIw11avtsgIGnbNyAF0INfQs+GPTlGOQvA
j3cNLGrfw6bDIKloyLfUA7+P8iCTBaTX2tpO+FyX2Sg9N0nfPFH6yqPLvqhznwPi
Dt+U26hCtuM=
=Ofym
-----END PGP SIGNATURE-----

--==_Exmh_1571934467_59326P--
