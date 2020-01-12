Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918E01386D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbgALOrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 09:47:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbgALOrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 09:47:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so7894115wmd.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dOrsfyRmVgTXeGGW9Jq1FNHFR+dST2yOx0HfkK9Pv9s=;
        b=nq1th4/EZ7RZCYAlPJrkHqD7LESMDyoQNHLoo+akNy+AedheFwUDfIDakSj06YcCjt
         KwXEAS7XiisqhShYW0X0k0F7gS6O7aycvbfyZeL+P0WSaLI9zvm6BBAPEawIWuKpptSK
         j2hWFPZ/7BYEassdGdtDonbH1yRhQgww04EzTeX4pB3Anw7Cq4/3JesuSS2R4qFvgqgZ
         D5OpcAxqeWMGIL6QTZqX7jLsAy51+Hr5p1oo8P87SrsOnHsBfCOuDCsXfKPTqj6vsI3l
         ftHDArV384+c2P8ADT9Io0e7acJpfJVvr2ADJoQt4N1CM9ayf0uu0L7pQkGJ7qJc+uxa
         TROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dOrsfyRmVgTXeGGW9Jq1FNHFR+dST2yOx0HfkK9Pv9s=;
        b=aprrTth3DYmdFKiuHDdHNRUNc4nTXCxruu3v8ZAWJgtEJCZ+n/NVUZFDTsozFIgbMX
         pCwmMBYfwhU/vzoXwNUc+3TWPpuKlPPMarbX720KjmzaslgkpvJqTtXt07LxKiLEJRVw
         9G7XgKfYYgdh/QNdpEAeFByCSgTcj29GhMM0aYlscSpidLcSCB8bvI3ORuaZU5LQ+NtE
         B3FgWLjRWFy9IUbPOhXZ47+bFRgVW3ztvkYsJygleomE+GbPs5I1Ox+1yMrQy6zx5jQ3
         V0ftE03BR2qKGRjZalGmAnbFscRtu7yiL8WQCKnA6LS1Ep6WzLQXL/cajoRweO3zE3+Q
         olVg==
X-Gm-Message-State: APjAAAW3AZMdqb9jW5iGfkaAu0dsvFsMrJhcxiRzsdEY5BjhmSEnxxsF
        vY2Q6OomPetkhL4O+w6m/9gLpQx4
X-Google-Smtp-Source: APXvYqzMv28R49oB/yq7tkr8/h9jk31nWU5YgGQZwFioAHicOaUxddZJqBcBFZu6smG+O3u/bEUAtg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr15376266wmi.89.1578840457515;
        Sun, 12 Jan 2020 06:47:37 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i10sm11045750wru.16.2020.01.12.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 06:47:36 -0800 (PST)
Date:   Sun, 12 Jan 2020 15:47:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke CD-RW
 support
Message-ID: <20200112144735.hj2emsoy4uwsouxz@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="covvha46va3s45fn"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--covvha46va3s45fn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Commit b085fbe2ef7fa (udf: Fix crash during mount) introduced check that
UDF disk with PD_ACCESS_TYPE_REWRITABLE access type would not be able to
mount in R/W mode. This commit was added in Linux 4.20.

But most tools which generate UDF filesystem for CD-RW set access type
to rewritable, so above change basically disallow usage of CD-RW discs
formatted to UDF in R/W mode.

Linux's cdrwtool and mkudffs (in all released versions), Windows Nero 6,
NetBSD's newfs_udf -- all these tools uses rewritable access type for
CD-RW media.

In UDF 1.50, 2.00 and 2.01 specification there is no information which
UDF access type should be used for CD-RW medias.

In UDF 2.60, section 2.2.14.2 is written:

    A partition with Access Type 3 (rewritable) shall define a Freed
    Space Bitmap or a Freed Space Table, see 2.3.3. All other partitions
    shall not define a Freed Space Bitmap or a Freed Space Table.

    Rewritable partitions are used on media that require some form of
    preprocessing before re-writing data (for example legacy MO). Such
    partitions shall use Access Type 3.

    Overwritable partitions are used on media that do not require
    preprocessing before overwriting data (for example: CD-RW, DVD-RW,
    DVD+RW, DVD-RAM, BD-RE, HD DVD-Rewritable). Such partitions shall
    use Access Type 4.

And in 6.14.1 (Properties of CD-MRW and DVD+MRW media and drives) is:

    The Media Type is Overwritable (partition Access Type 4,
    overwritable)

Similar info is in UDF 2.50.

So I think that UDF 2.60 is clear that for CD-RW medias (formatted in
normal or MRW mode) should be used Overwritable access type. But all
mentioned tools were probably written prior to existence of UDF 2.60
specifications, probably targeting only UDF 1.50 versions at that time.

I checked that they use Unallocated Space Bitmap (and not Freed Space
Bitmap), so writing to these filesystems should not be a problem.

How to handle this situation? UDF 2.01 nor 1.50 does not say anything
for access type on CD-RW and there are already tools which generates UDF
1.50 images which does not matches UDF 2.60 requirements.

I think that the best would be to relax restrictions added in commit
b085fbe2ef7fa to allow mounting mounting udf fs with rewritable access
type in R/W mode if Freed Space Bitmap/Table is not used.

I'm really not sure if existing udf implementations take CD-RW media
with overwritable media type. E.g. prehistoric wrudf tool refuse to work
with optical discs which have overwritable access type. I supports only
UDF 1.50.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--covvha46va3s45fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhsxhQAKCRCL8Mk9A+RD
UnPYAJ9e/KG9iPWabYYAZMoCqVxNYckvSgCfUdVUibSu2AZ6+iKMLBNz1lQxpQI=
=NYtz
-----END PGP SIGNATURE-----

--covvha46va3s45fn--
