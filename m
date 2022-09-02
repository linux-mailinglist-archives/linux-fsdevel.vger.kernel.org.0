Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A674F5AABA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiIBJlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiIBJld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A82E9F2;
        Fri,  2 Sep 2022 02:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFA861E36;
        Fri,  2 Sep 2022 09:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A824DC433C1;
        Fri,  2 Sep 2022 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662111691;
        bh=JlfZEPKunXFgiUrPOyu21ml9zgBI6rBnRu5PPuVieRY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rIqWPkvCOvhlXJFByMsyv0QO8bZMo61rs7r9Wbk25ArWcFO2vQt+Xm6xBVrU1FuIC
         +MHOX2Okv4ySJbC6lE8PIQKo7d5HLfL3eO7Z1YWb7XRuHWzYJfhiN/H5MbRYqsUG5l
         kWL2vxyT+QwLb8eXbUF1AD40xK7JJZylXmjY61lqrLu7ZgXh3/9hpT8MJSIvf3oT9O
         gRUuHnbKNMaw8qUXl0TyHeZOgreozZJ1LNO/H9yHDtezUqnmhQJwiZSPLd7NT3GhJK
         fSdn4m5Pc6lXJqz57N/1naXCBPhRn8XejzYxSnwuwUyn6Qak/BgtArji0WycjuhUvd
         /Tl2ZaJSF+SyA==
Message-ID: <5167c66c0a3285d2d3188871250af77df3919635.camel@kernel.org>
Subject: Re: [xfstests PATCH] generic/693: add basic change attr test
From:   Jeff Layton <jlayton@kernel.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 02 Sep 2022 05:41:29 -0400
In-Reply-To: <CADJHv_ufx=k+HGbL8wChLVXLsv-HOgzdMMfU4eUfnV3dZFMnaQ@mail.gmail.com>
References: <20220816133413.44298-1-jlayton@kernel.org>
         <CADJHv_ufx=k+HGbL8wChLVXLsv-HOgzdMMfU4eUfnV3dZFMnaQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for having a look. I should probably have marked this as an RFC
patch. The infrastructure for this is still being debated on the mailing
lists. Until that's settled we won't want to merge this.

Cheers,
Jeff

On Fri, 2022-09-02 at 09:28 +0800, Murphy Zhou wrote:
> Hi Jeff,
>=20
> Thanks for the patch!
>=20
> On Tue, Aug 16, 2022 at 9:43 PM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Now that we have the ability to query the change attribute in userland,
> > test that the filesystems implement it correctly. Fetch the change
> > attribute before and after various operations and validate that it
> > changes (or doesn't change) as expected.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/rc             |  17 ++++++
> >  tests/generic/693     | 138 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/693.out |   1 +
> >  3 files changed, 156 insertions(+)
> >  create mode 100755 tests/generic/693
> >  create mode 100644 tests/generic/693.out
> >=20
> > Please look and make sure I'm not missing other operations that we
> > should be testing here!
> >=20
> > diff --git a/common/rc b/common/rc
> > index 197c94157025..b9cb47f99016 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5052,6 +5052,23 @@ hexdump()
> >         _fail "Use _hexdump(), please!"
> >  }
> >=20
> > +_require_change_attr ()
> > +{
> > +
> > +       _mask=3D$($XFS_IO_PROG -f -c "statx -m 0x2000 -r" $TEST_DIR/cha=
nge_attr_test.$$ \
> > +               | grep "^stat.mask" | cut -d' ' -f 3)
> > +       rm -f $TEST_DIR/change_attr_test.$$
> > +       if [ $(( ${_mask}&0x2000 )) -eq 0 ]; then
> > +               _notrun "$FSTYP does not support inode change attribute=
"
> > +       fi
> > +}
> > +
> > +_get_change_attr ()
> > +{
> > +       $XFS_IO_PROG -r -c "statx -m 0x2000 -r" $1 | grep '^stat.change=
_attr' | \
> > +               cut -d' ' -f3
> > +}
> > +
> >  init_rc
> >=20
> >  ######################################################################=
##########
> > diff --git a/tests/generic/693 b/tests/generic/693
> > new file mode 100755
> > index 000000000000..fa92931d2ac8
> > --- /dev/null
> > +++ b/tests/generic/693
> > @@ -0,0 +1,138 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> > +#
> > +# FS QA Test No. 693
> > +#
> > +# Test the behavior of the inode change attribute
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick rw
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_change_attr
> > +
> > +# from the stat.h header file
> > +UTIME_OMIT=3D1073741822
> > +
> > +testdir=3D"$TEST_DIR/test_iversion_dir.$$"
> > +testfile=3D"$testdir/test_iversion_file.$$"
> > +
> > +mkdir $testdir
> > +
> > +# DIRECTORY TESTS
> > +#################
> > +# Does dir change attr change on a create?
> > +old=3D$(_get_change_attr $testdir)
> > +touch $testfile
> > +new=3D$(_get_change_attr $testdir)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr of dir did not change after create!"
> > +fi
> > +
> > +# on a hardlink?
> > +old=3D$new
> > +ln $testfile $testdir/linky
>=20
> We may need to clean up these temporary testing files.
>=20
> Other parts look good to me.
>=20
> Regards~
>=20
> > +new=3D$(_get_change_attr $testdir)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr of dir did not change after hardlink!"
> > +fi
> > +
> > +# on an unlink?
> > +old=3D$new
> > +rm -f $testfile
> > +new=3D$(_get_change_attr $testdir)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr of dir did not change after unlink!"
> > +fi
> > +
> > +# on a rename (within same dir)
> > +old=3D$new
> > +mv $testdir/linky $testfile
> > +new=3D$(_get_change_attr $testdir)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr of dir did not change after rename!"
> > +fi
> > +
> > +# on a mknod
> > +old=3D$new
> > +mknod $testdir/pipe p
> > +new=3D$(_get_change_attr $testdir)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr of dir did not change after mknod!"
> > +fi
> > +
> > +
> > +# REGULAR FILE TESTS
> > +####################
> > +# ensure change_attr changes after a write
> > +old=3D$(_get_change_attr $testfile)
> > +$XFS_IO_PROG -c "pwrite -W -q 0 32" $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after write!"
> > +fi
> > +
> > +# ensure it doesn't change after a sync
> > +old=3D$new
> > +sync
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old !=3D $new ]; then
> > +       _fail "Change attr changed after sync!"
> > +fi
> > +
> > +# ensure change_attr does not change after read
> > +old=3D$new
> > +cat $testfile > /dev/null
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old !=3D $new ]; then
> > +       _fail "Change attr changed after read!"
> > +fi
> > +
> > +# ensure it changes after truncate
> > +old=3D$new
> > +truncate --size 0 $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after truncate!"
> > +fi
> > +
> > +# ensure it changes after only atime update
> > +old=3D$new
> > +$XFS_IO_PROG -c "utimes 1 1 $UTIME_OMIT $UTIME_OMIT" $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after atime update!"
> > +fi
> > +
> > +# ensure it changes after utimes atime/mtime update
> > +old=3D$new
> > +$XFS_IO_PROG -c "utimes 1 1 1 1" $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after mtime update!"
> > +fi
> > +
> > +# after setting xattr
> > +old=3D$new
> > +setfattr -n user.foo -v bar $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after setxattr!"
> > +fi
> > +
> > +# after removing xattr
> > +old=3D$new
> > +setfattr -x user.foo $testfile
> > +new=3D$(_get_change_attr $testfile)
> > +if [ $old =3D $new ]; then
> > +       _fail "Change attr did not change after rmxattr!"
> > +fi
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/693.out b/tests/generic/693.out
> > new file mode 100644
> > index 000000000000..89ad553d911c
> > --- /dev/null
> > +++ b/tests/generic/693.out
> > @@ -0,0 +1 @@
> > +QA output created by 693
> > --
> > 2.37.2
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
