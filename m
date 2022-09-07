Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF55AFC3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 08:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIGGPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIGGPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279C56CF5C
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662531318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4az1HQKb/HIdHmleJaWvrZvYTAApZUEhXiynTldmky0=;
        b=L2dCa7MRfTGgcFSHH+hPxjj3KmjIT7Nhg2hyllNa3KMdtE/Qa6xga6O5oAVM/w4j0Nwxak
        1uWBVOpnikMfufBSNowZ9Gg/SDsBUb/bwJWjlgXDhx+F4w+5roXLtprHsIO6oQ9BX10qWt
        Iorq3uiTTTqAkwDeniicZFmQMRk91T4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-9K7eDHMfMX-BuslO2rMT6A-1; Wed, 07 Sep 2022 02:15:12 -0400
X-MC-Unique: 9K7eDHMfMX-BuslO2rMT6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13407811E87;
        Wed,  7 Sep 2022 06:15:12 +0000 (UTC)
Received: from butterfly.localnet (unknown [10.40.192.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9035540CF916;
        Wed,  7 Sep 2022 06:15:07 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Renaud =?ISO-8859-1?Q?M=E9trich?= <rmetrich@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
Date:   Wed, 07 Sep 2022 08:15:06 +0200
Message-ID: <5599808.DvuYhMxLoT@redhat.com>
Organization: Red Hat
In-Reply-To: <87r10ob0st.fsf@email.froward.int.ebiederm.org>
References: <20220903064330.20772-1-oleksandr@redhat.com> <87r10ob0st.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On st=C5=99eda 7. z=C3=A1=C5=99=C3=AD 2022 0:22:42 CEST Eric W. Biederman w=
rote:
> Oleksandr Natalenko <oleksandr@redhat.com> writes:
>=20
> > Statistically, in a large deployment regular segfaults may indicate a C=
PU issue.
> >
> > Currently, it is not possible to find out what CPU the segfault happene=
d on.
> > There are at least two attempts to improve segfault logging with this r=
egard,
> > but they do not help in case the logs rotate.
> >
> > Hence, lets make sure it is possible to permanently record a CPU
> > the task ran on using a new core_pattern specifier.
>=20
> I am puzzled why make it part of the file name, and not part of the
> core file?  Say an elf note?

This might be a good idea too, and one approach doesn't exclude the other o=
ne.

> The big advantage is that you could always capture the cpu and
> will not need to take special care configuring your system to
> capture that information.

The advantage of having CPU recorded in the file name is that in case of mu=
ltiple cores one can summarise them with a simple ls+grep without invoking =
a fully-featured debugger to find out whether the segfaults happened on the=
 same CPU.

Thanks.

> Eric
>=20
> > Suggested-by: Renaud M=C3=A9trich <rmetrich@redhat.com>
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 1 +
> >  fs/coredump.c                               | 5 +++++
> >  include/linux/coredump.h                    | 1 +
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
> > index 835c8844bba48..b566fff04946b 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -169,6 +169,7 @@ core_pattern
> >  	%f      	executable filename
> >  	%E		executable path
> >  	%c		maximum size of core file by resource limit RLIMIT_CORE
> > +	%C		CPU the task ran on
> >  	%<OTHER>	both are dropped
> >  	=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > =20
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index a8661874ac5b6..166d1f84a9b17 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -325,6 +325,10 @@ static int format_corename(struct core_name *cn, s=
truct coredump_params *cprm,
> >  				err =3D cn_printf(cn, "%lu",
> >  					      rlimit(RLIMIT_CORE));
> >  				break;
> > +			/* CPU the task ran on */
> > +			case 'C':
> > +				err =3D cn_printf(cn, "%d", cprm->cpu);
> > +				break;
> >  			default:
> >  				break;
> >  			}
> > @@ -535,6 +539,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >  		 */
> >  		.mm_flags =3D mm->flags,
> >  		.vma_meta =3D NULL,
> > +		.cpu =3D raw_smp_processor_id(),
> >  	};
> > =20
> >  	audit_core_dumps(siginfo->si_signo);
> > diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> > index 08a1d3e7e46d0..191dcf5af6cb9 100644
> > --- a/include/linux/coredump.h
> > +++ b/include/linux/coredump.h
> > @@ -22,6 +22,7 @@ struct coredump_params {
> >  	struct file *file;
> >  	unsigned long limit;
> >  	unsigned long mm_flags;
> > +	int cpu;
> >  	loff_t written;
> >  	loff_t pos;
> >  	loff_t to_skip;

=2D-=20
Oleksandr Natalenko (post-factum)
Principal Software Maintenance Engineer


