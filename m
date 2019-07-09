Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA762D34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 02:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfGIA6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 20:58:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51962 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725857AbfGIA6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:58:32 -0400
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x690wVM2013763
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Jul 2019 20:58:31 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x690wQ88030113
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Jul 2019 20:58:31 -0400
Received: by mail-qk1-f199.google.com with SMTP id c1so17910735qkl.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 17:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=gzjvIBvyoxXf9yZx+IjvTDWM/EMMxHOR9DhJMARvWU4=;
        b=jj8cdC72Ssy+JYgxeE8joBOJBC+FgmzeFxWzAO1U2ZNxpfwhY9HuyHjUbSzihABn3j
         pI24TENU2daOz6RqoAoURuVJG2RNjC3U5qtnpYc6QRFl3AKq/i+U3lat5lybp3UU0WCj
         1TXgtozY++6Eo54/74vLVEXFxALmp44YxBOvMQkOfV8TmLrrYAOn56s0PQSf/wTvaJVW
         IPdcQXU7PJmEK5JkjEIbIdH4PPdR3UuXFpG8ITAlllXr+Xy2bKhWwl5zkHhZrFUb04pW
         q3yKj1d5gHK+q2mnpCNc4aN7XnYUkFI0pUphaSX5Plufj8kP5/CJ+/YlKj2p78Ybmtxe
         O7lA==
X-Gm-Message-State: APjAAAUmdHBffZBF2nTGw+at+3O9bUomFwtPyOy4UOxzM8+Cj6ptmWef
        at4d73MorezNIsb5sN/oJhIfH6k3ATM3J5Nf+hStJFpSd8A23AbME3JIZvO3gATvo0DSy7qCnYw
        99sSSEnc2q+wb3SoUi4qIi8TeYHlNNW4S+B2S
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr16325646qtf.204.1562633906030;
        Mon, 08 Jul 2019 17:58:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysL21EgSuDTcXeor1Ws1wtBJMH7dhipNrrhZP3IsCALzATUekN4qK2xdB6CIFg63K4PfkUCw==
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr16325637qtf.204.1562633905878;
        Mon, 08 Jul 2019 17:58:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id r40sm7679907qtk.2.2019.07.08.17.58.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:58:24 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
In-Reply-To: <20190709005220.GZ17978@ZenIV.linux.org.uk>
References: <21080.1562632662@turing-police>
 <20190709005220.GZ17978@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562633903_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jul 2019 20:58:23 -0400
Message-ID: <3099.1562633903@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1562633903_2389P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jul 2019 01:52:20 +0100, Al Viro said:
> On Mon, Jul 08, 2019 at 08:37:42PM -0400, Valdis Klētnieks wrote:
> > I have an out-of-tree driver for the exfat file system that I beaten into shape
> > for upstreaming. The driver works, and passes sparse and checkpatch (except
> > for a number of line-too-long complaints).
> >
> > Do you want this taken straight to the fs/ tree, or through drivers/staging?
>
> First of all, post it...

OK... Ill post it as if it's going in fs/ and if people disagree, I'll repost it for
drivers/staging (once any other complaints have been corrected)...


--==_Exmh_1562633903_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSPmrgdmEQWDXROgAQKCHxAAurpyzrYfy7Qc1FjCJnO+WfvaWzgpnXOC
tD2BSYOKhkrsKYl2phZvfPT+O4jbhq3dgSZ0z/ibewHPe4+9ePTaahxGArr0YZ1a
eogU7nGc5RDE/PGQhfR/Aawk853YMxyDCZs5EWSjjR+gYbVCt2LsN6A2DcEMjPPt
Af9/Qa3Jl8fkJIJgEd3Y7ysjmos+9caFDSvGC0n1xG3OgRHvyDkNFR32CbXsQQ/n
gZT/D6HCzYkL8+x1b7jBD4Ow+tMolC00Itw+8Bn9hsvd6fVqWOH/gs2QatyPUzum
2kbQmq6qHUNBr3qiDwwLyegBHvkzlX+pwZN9djGnKz313uxBZTQxJOQHTVjLJ5Ct
AVwzYYGloc3eiGniTTWKLzO/KEe10UapSwhH0kVih1q4NKWHYXAewPMsfQssWPjZ
dhcxSt5pKULnm3TCTM3oqcOuprx3FRzsR4GAKDy92H2tK6oqfuiJL3yLVWiUa6/v
2BV6e6q3jq8CRwNuU1d1Ko6WOBfWFJXUd9ALsmg9JVlFpjmUZdhkD3oWeYOY0pV9
1n5Ceyt3jOrxi58qyX1CQsA0lvYVUPYMmjvCjk68/pQ5TByMs6YF3A1CArihRPuP
/kcD3GFFjx9WC2bmE+yaednjs/SEUBUHBKfGbJ7K3fCaBhJJHOASyuh+aRpn0zTF
6zCXSRzm+bQ=
=6ylh
-----END PGP SIGNATURE-----

--==_Exmh_1562633903_2389P--
