Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4736D72E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 06:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjDEEFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEEFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:05:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746E30ED;
        Tue,  4 Apr 2023 21:05:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so44958715lfa.7;
        Tue, 04 Apr 2023 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680667506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJlfy7j3jMnUpTZd8i2RXdQGxubaR4kSxjiHyHktxQU=;
        b=GBLwfW9UJi4zFmg7y/9EKT5SVpOWVKBcOTg6x2OXZDoySEjA2NqEqCXXNliCGLdrIm
         nANtfragDQ9GodkTcqPEAwnnOqLt5VwYILPmMXwTJFTkSdNjfkKykk8r1Y6VQtyxw4tz
         49QTfWGO301+AXZ/tDP5Os97+TmEQtoTmx7a7D6G9iTjsDFMSK0NXGVLS1XFRV6pXVnF
         Vgwi2jCdR+MWGco8cnyO9eIaxK6aByiWUuxhZp86TQv5vGBeDDUblpJ1ckYg8FnjBo47
         vP04pmkcKH+Z2oHyTnSv5LBe8lrlwt2GBG52teC3ieI2/iHqJRH7hKihvKUPAsZrzDCc
         3clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680667506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJlfy7j3jMnUpTZd8i2RXdQGxubaR4kSxjiHyHktxQU=;
        b=3BYwUUwbDSwPeG12S9ctuxAu0dLcauWDWIn4iHy4rd6KETp0c78FulPEKxhmaG8lZD
         3DRltotaJ6NX3Wf0AguofRM1M/QSSFm/Iu7vSgRWjimMg6j5wAxfqSEezyrmqA3S880x
         dT7KZkQJrURvH7lxbHLIajpqZR5c7J3DoA1dOzijDKCxsC4M246F4Vkyciiw3f4oHKZ2
         SaFONqKFNtuHW5VjAMkab/rld0HHgDPktzOXoQ7rWsxkUWNG3j6k0+4DPvzCjGYrYijx
         ngxkcRvB/SeL4QtGk37TFuBjsD1+JreLhL0mejN7S1wQBxuhZ+SoVeN4HUWJOHxoJTUz
         IpWg==
X-Gm-Message-State: AAQBX9c8McvIJZeiL2wN0jS5RqyTTuuh8wcqOAjutCa2CFnO6+XAe/lK
        dN2RYxO2PD2sWgyrL32LWKiNSNfFk0ttSPYAJzY=
X-Google-Smtp-Source: AKy350YUnFw6FnCbM4/rIL7SfmUol3E7+vdFKY2q63D6zsUvp1WRxA+9ht3amnQRmHWnL/rEG8hkq3VPj2+tk7SUk4c=
X-Received: by 2002:ac2:5291:0:b0:4e9:22ff:948d with SMTP id
 q17-20020ac25291000000b004e922ff948dmr1405756lfm.7.1680667505632; Tue, 04 Apr
 2023 21:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230404171411.699655-1-zlang@kernel.org> <20230404171411.699655-4-zlang@kernel.org>
 <20230404232159.GB109960@frogsfrogsfrogs>
In-Reply-To: <20230404232159.GB109960@frogsfrogsfrogs>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 4 Apr 2023 23:04:53 -0500
Message-ID: <CAH2r5mtmppW-vVdBAnxgH3zsH0b9pMUJyT=s3WTr9dnfwpHrWw@mail.gmail.com>
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        anand.jain@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Steven French <stfrench@microsoft.com>

On Tue, Apr 4, 2023 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> > The fstests supports different kind of fs testing, better to cc
> > specific fs mailing list for specific fs testing, to get better
> > reviewing points. So record these mailing lists and files related
> > with them in MAINTAINERS file.
> >
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >
> > If someone mailing list doesn't want to be in cc list of related fstest=
s
> > patch, please reply this email, I'll remove that line.
> >
> > Or if I missed someone mailing list, please feel free to tell me.
> >
> > Thanks,
> > Zorro
> >
> >  MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 09b1a5a3..620368cb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -107,6 +107,83 @@ Maintainers List
> >         should send patch to fstests@ at least. Other relevant mailing =
list
> >         or reviewer or co-maintainer can be in cc list.
> >
> > +BTRFS
> > +L:   linux-btrfs@vger.kernel.org
> > +S:   Supported
> > +F:   tests/btrfs/
> > +F:   common/btrfs
> > +
> > +CEPH
> > +L:   ceph-devel@vger.kernel.org
> > +S:   Supported
> > +F:   tests/ceph/
> > +F:   common/ceph
> > +
> > +CIFS
> > +L:   linux-cifs@vger.kernel.org
> > +S:   Supported
> > +F:   tests/cifs
> > +
> > +EXT4
> > +L:   linux-ext4@vger.kernel.org
> > +S:   Supported
> > +F:   tests/ext4/
> > +F:   common/ext4
> > +
> > +F2FS
> > +L:   linux-f2fs-devel@lists.sourceforge.net
> > +S:   Supported
> > +F:   tests/f2fs/
> > +F:   common/f2fs
> > +
> > +FSVERITY
> > +L:   fsverity@lists.linux.dev
> > +S:   Supported
> > +F:   common/verity
> > +
> > +FSCRYPT
> > +L:      linux-fscrypt@vger.kernel.org
> > +S:   Supported
> > +F:   common/encrypt
> > +
> > +FS-IDMAPPED
> > +L:   linux-fsdevel@vger.kernel.org
> > +S:   Supported
> > +F:   src/vfs/
> > +
> > +NFS
> > +L:   linux-nfs@vger.kernel.org
> > +S:   Supported
> > +F:   tests/nfs/
> > +F:   common/nfs
> > +
> > +OCFS2
> > +L:   ocfs2-devel@oss.oracle.com
> > +S:   Supported
> > +F:   tests/ocfs2/
> > +
> > +OVERLAYFS
> > +L:   linux-unionfs@vger.kernel.org
> > +S:   Supported
> > +F:   tests/overlay
> > +F:   common/overlay
> > +
> > +UDF
> > +R:   Jan Kara <jack@suse.com>
> > +S:   Supported
> > +F:   tests/udf/
> > +
> > +XFS
> > +L:   linux-xfs@vger.kernel.org
> > +S:   Supported
> > +F:   common/dump
> > +F:   common/fuzzy
> > +F:   common/inject
> > +F:   common/populate
>
> note that populate and fuzzy apply to ext* as well.
>
> > +F:   common/repair
> > +F:   common/xfs
> > +F:   tests/xfs/
>
> Otherwise looks good to me,
>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
> > +
> >  ALL
> >  M:   Zorro Lang <zlang@kernel.org>
> >  L:   fstests@vger.kernel.org
> > --
> > 2.39.2
> >



--=20
Thanks,

Steve
