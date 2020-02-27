Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166CB1710A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgB0Fxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:53:40 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43788 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgB0Fxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:53:39 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01R5rc7w007325
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:53:38 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01R5rXn9010235
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:53:38 -0500
Received: by mail-qv1-f72.google.com with SMTP id f17so2261695qvi.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 21:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=ptwIgNl4i28mcg0Z1zyc5XtWjo/QODMLAPuj6bjdS1w=;
        b=PwSfwT8MgGRI8kFDFL1OKaEnohRd4QwB2frxCViYvKQ3HmusqR/TPg3y3CbuO9w72f
         NaqGu9OT3VD/vmbaM0uPPUTPZaGZ2m/1sexsOMZqLHew6cy22hXjRrl2iX+mgLbvDcWC
         L+Kf5NYXdZTVhPQE/ZyzCusHWxBvhb6nwnpwTwoN0EFBJKtjdIVYp2Iz7NwbotyczKwF
         kfFknvkLuPvZ6PKshjK/hyQF+/cI/oiZbmww9xii3rTSTllbQ4QvEIN1AkxddIAm1kzc
         5BWx6x97nrlSXUQ65EnpHUBCgBOU5TJxWvUAPPAR1kdunaasxCP7UkihC+s82swfkXbM
         jZsw==
X-Gm-Message-State: APjAAAUUvuApsvqrT3FiYVkYdyCSF7ciiuxvOH8rftCKOUKeEYVe1oNk
        wqbi33mPJXRez3bf7uf+TopOAb8iWCc5TfkHhReUwkFpW9RUi7POw2yVFzcG8HH+c2PRi5kO+X9
        DMYbZV8PJCGnAYUVQ1EtJwLLflR7B2KXvRTIu
X-Received: by 2002:aed:36a5:: with SMTP id f34mr2937478qtb.57.1582782813080;
        Wed, 26 Feb 2020 21:53:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKZNWw/Ucu3Q9y81YAA8eBCVTAtZbF4AqqV3+ZJLEQt/+PiY3p3EXhCgITppc1rAjYtpI8dA==
X-Received: by 2002:aed:36a5:: with SMTP id f34mr2937463qtb.57.1582782812775;
        Wed, 26 Feb 2020 21:53:32 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id a23sm2500067qko.77.2020.02.26.21.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 21:53:31 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: remove symlink feature : Additional patch
In-Reply-To: <TY1PR01MB1578C8F3D1A9F130C5844C6890EB0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200226063746.3128-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp> <503049.1582701983@turing-police>
 <TY1PR01MB1578C8F3D1A9F130C5844C6890EB0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1582782809_2726P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 00:53:30 -0500
Message-ID: <59586.1582782810@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1582782809_2726P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Feb 2020 02:14:02 +0000, "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" said:
> Thanks for comment.
>
> > Then this should have been [PATCH v2], and the fixed version [PATCH
> > v3]
>
> 2nd patch(Additional patch) not include 1st patch(RFC PATCH).
> And the 1st patch has been merged into 'staging-next'.
> Now I can't decide.
> a) Add only version information to the 2nd patch.
> b) Merge the 1st and 2nd patches.
>
> Which is better for v3?

The first part is in-tree, so we don't re-visit it in this case.  You want a
new patch that consists of *only* the second set of changes, and the changelog
for the changes for that patch.

--==_Exmh_1582782809_2726P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXldZWQdmEQWDXROgAQIe9g//Wa+udzeaAQxzyO1/RnzWU7l+jHb32Ajw
CvOd+3qd7H0qwL5/yvAXUs23rioz3kaCVYVFfqVUMtVZJx6dju+rSvMAgRC6OLb9
akWUEM0iL85V4NcjcQfwkf6koYb6wBrC0OKzfT1QRqUT7yeYTjqUxf2e+loHCHd/
uwGX60hksVsr4IgGRo8+7BISvbR+4DMrc2S6d/Ha2RtXi4FnnOldNcpXMjozCHrS
IdyqlkAmS1nG3RQsQ1g+iJo9CmwwZ7BL/OWft8yAMq9DBy2JvmhQmCq/dUeKaFnc
EM91Zh6lr2NYuwia+ff51ERDibuWJW10uxKYlnu/yl/0JUtmY6OHWxMxcD5QGaNy
F5KgTaRuCaxAsxb5mySNw2xrgu7bdOxVOKr5dSnm1dYeQYzRNG6o8mGsHxqH4JD0
Kbo8Ftr/RYkJYkhEHcpNKxxiwh/+nAFP5g72af1h605hLUJGAL2QsbBFu+/4aK5q
x4fsyUvfM78/Q+3tWwR8bPhmEx1hjuD5DNKIKbgEtYE9M9u93YzKcdY34KsE/yIk
2Ycy9IF/mnP2MCUBcqgQmgZaGmjgeqT4qgGWENEzFRR1qYT6T5cvZkCNS57TVqTJ
+trmkqBVc2aJD/zYibq5kymmBzGnI11N0lq7+nAnYwIEiUrEmzMXuf90vI7ocaP2
vKVSFcGO0u0=
=mg3v
-----END PGP SIGNATURE-----

--==_Exmh_1582782809_2726P--
