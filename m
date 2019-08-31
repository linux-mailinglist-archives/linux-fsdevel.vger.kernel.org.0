Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569BBA4400
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHaKZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 06:25:36 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42778 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726942AbfHaKZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:25:36 -0400
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7VAPU56003970
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 06:25:30 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7VAPPV4012781
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 06:25:30 -0400
Received: by mail-qt1-f197.google.com with SMTP id e32so9887244qtc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 03:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=gOon/h8n+ssSdE+jIkeR30mWeF4AJKfgEeySSiAwLSA=;
        b=FVEUz1qEb6HRGLAFHzZ2BfkogvvJr4Br72EdXQTB1RTSKMPQDcKW+mrZO79E64VAnw
         dVpKQrlPneGjy/RXQ2VqKwUtLGdjEpT9GKYdJ31IQlb/qf2xX1gJuQqVClHXlx+ojHAU
         UACIN7qdzecrnuwWqaP0Kz37/ogTmacyti/GzaWXvaWboFLzB6UYOxMJpHqIUr2FqsfD
         qyVVwo98sat/AzQ3RtQoXJU0OcqlzavyQtXgdOAtgPWvk5WtMDBPfKfWevaljj5MOcN1
         G+ue8BqKNuhFMFTMRb2GMtAKJG+xDf3pfx0KumA5KjLaRlGYfLzdVj8kJAaa398ZeJA7
         QgaA==
X-Gm-Message-State: APjAAAU9uaqXSrLp9hgP75lGp6u6t00TERmpvg1vhIqd640IQCMctAK8
        sZLLUoGH/p+4HeuEGUzDpa3dTzcFXS9ZvceG5kylw8jpgHqTy5kaNFnf2O8JXIdfDLfzwPngFFW
        ZPAHws1Od+JllHKIRHKG1G5xXsp2lC0Gx7usK
X-Received: by 2002:a37:4c9:: with SMTP id 192mr228893qke.177.1567247124657;
        Sat, 31 Aug 2019 03:25:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4t9yp593KmKXp0uHgxAGE/BeYUK9rKIDn+7O77ScK2qKJSBZu+YUb/4yZ0ijyEz4Pn/3FZg==
X-Received: by 2002:a37:4c9:: with SMTP id 192mr228844qke.177.1567247123956;
        Sat, 31 Aug 2019 03:25:23 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id z5sm370926qtb.49.2019.08.31.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 03:25:22 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190831064616.GA13286@infradead.org>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567247121_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 06:25:21 -0400
Message-ID: <295233.1567247121@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567247121_4251P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2019 23:46:16 -0700, Christoph Hellwig said:

> Since when did Linux kernel submissions become =22show me a better patc=
h=22
> to reject something obviously bad?

Well, do you even have a *suggestion* for a better idea?  Other than =22j=
ust rip
it out=22?  Keeping in mind that:

> As I said the right approach is to probably (pending comments from the
> actual fat maintainer) to merge exfat support into the existing fs/fat/=

> codebase.  You obviously seem to disagree (and at the same time not).

At this point, there isn't any true consensus on whether that's the best
approach at the current. =22Just rip it out=22 prevents following some di=
rections
that people have voiced interest in.  Now, if there was consensus that we=

wanted a separate module that only did exfat, you'd be correct.

And just for the record, I've been around since the 2.5.47 or so kernel, =
and
I've seen *plenty* of times when somebody has submitted a better alternat=
ive
patch.

> But using this as a pre-text of adding a non-disabled second fat16/32
> implementation and actually allowing that to build with no reason is
> just not how it works.

Well.. let's see... It won't build unless you select CONFIG_STAGING.  *An=
d* you
select CONFIG_EXFAT_FS. *And* it wont mount anything other than exfat
unless you change CONFIG_EXFAT_DONT_MOUNT_VFAT

I think at that point, we can safely say that if it mounts a vfat filesys=
tem,
it's because the person building the kernel has gone out of their way to
request that it do so.

Either that, or we have a major bug in kbuild. In general, kbuild doesn't=
 build
things =22for no reason=22.

Now, if what you want is =22Please make it so the fat16/fat32 code is in =
separate
files that aren't built unless requested=22, that's in fact doable and a
reasonable request, and one that both doesn't conflict with anything othe=
r
directions we might want to go, and also prepares the code for more easy
separation if it's decided we really do want an exfat-only module.

> > > done.  Given that you signed up as the maintainer for this what is =
your
> > > plan forward on it?  What development did you on the code and what =
are
> > > your next steps?
> >=20
> > Well, the *original* plan was to get it into the tree someplace so it=
 can get
> > review and updates from others.
>
> In other words you have no actual plan and no idea what to do and want =
to
> rely on =22others=22 to do anything, but at the same time reject the
> comments from others how to do things right?

So far, the only comment I've rejected is one =22just rip it out=22 that =
conflicts with
directions that others have indicated we may want to pursue.

And by the way, it seems like other filesystems rely on =22others=22 to h=
elp out.
Let's look at the non-merge commit for fs/ext4. And these are actual patc=
hes,
not just reviewer comments....

(For those who don't feel like scrolling - 77.6% of the non-merge ext4 co=
mmits
are from a total of 463 somebodies other than Ted Ts'o)

Even some guy named Christoph Hellwig gave Ted Ts'o a bunch of help.

=5B/usr/src/linux-next=5D git log -- fs/ext4 =7C awk '/=5Ecommit/ =7Bmerg=
e=3D0=7D /=5EMerge: / =7Bmerge=3D1=7D /=5EAuthor:/ =7B if (=21merge) =7Bp=
rint =240=7D=7D' =7C sort =7C uniq -c =7C sort -t: -k 1,1nr -k 2
    718 Author: Theodore Ts'o <tytso=40mit.edu>
    260 Author: Jan Kara <jack=40suse.cz>
    151 Author: Aneesh Kumar K.V <aneesh.kumar=40linux.vnet.ibm.com>
    120 Author: Eric Sandeen <sandeen=40redhat.com>
    119 Author: Lukas Czerner <lczerner=40redhat.com>
     99 Author: Dmitry Monakhov <dmonakhov=40openvz.org>
     84 Author: Al Viro <viro=40zeniv.linux.org.uk>
     67 Author: Eric Biggers <ebiggers=40google.com>
     63 Author: Tao Ma <boyu.mt=40taobao.com>
     61 Author: Yongqiang Yang <xiaoqiangnk=40gmail.com>
     49 Author: Zheng Liu <wenqing.lz=40taobao.com>
     47 Author: Christoph Hellwig <hch=40lst.de>
     42 Author: Darrick J. Wong <darrick.wong=40oracle.com>
     40 Author: Tahsin Erdogan <tahsin=40google.com>
     36 Author: Mingming Cao <cmm=40us.ibm.com>
     32 Author: Eric Whitney <enwlinux=40gmail.com>
     28 Author: Christoph Hellwig <hch=40infradead.org>
     27 Author: Curt Wohlgemuth <curtw=40google.com>
     24 Author: Darrick J. Wong <djwong=40us.ibm.com>
     22 Author: Akira Fujita <a-fujita=40rs.jp.nec.com>
     20 Author: Ross Zwisler <zwisler=40kernel.org>
     18 Author: Eryu Guan <guaneryu=40gmail.com>
     16 Author: Vasily Averin <vvs=40virtuozzo.com>
     15 Author: Akinobu Mita <akinobu.mita=40gmail.com>
     15 Author: Allison Henderson <achender=40linux.vnet.ibm.com>
     15 Author: Robin Dong <sanbai=40taobao.com>
     14 Author: Dan Carpenter <dan.carpenter=40oracle.com>
     13 Author: Michael Halcrow <mhalcrow=40google.com>
     13 Author: Miklos Szeredi <mszeredi=40suse.cz>
     13 Author: Wang Shilong <wshilong=40ddn.com>
     12 Author: Daeho Jeong <daeho.jeong=40samsung.com>
     12 Author: Jan Kara <jack=40suse.com>
     12 Author: Joe Perches <joe=40perches.com>
     12 Author: Tejun Heo <tj=40kernel.org>
     11 Author: Jiaying Zhang <jiayingz=40google.com>
     11 Author: Namjae Jeon <namjae.jeon=40samsung.com>
     11 Author: Shen Feng <shen=40cn.fujitsu.com>
     10 Author: David Howells <dhowells=40redhat.com>
     10 Author: Guo Chao <yan=40linux.vnet.ibm.com>
     10 Author: Matthew Wilcox <willy=40infradead.org>
      9 Author: Alexey Dobriyan <adobriyan=40gmail.com>
      9 Author: Andreas Gruenbacher <agruenba=40redhat.com>
      9 Author: Fabian Frederick <fabf=40skynet.be>
      9 Author: Linus Torvalds <torvalds=40linux-foundation.org>
      8 Author: Amir Goldstein <amir73il=40gmail.com>
      8 Author: Amir Goldstein <amir73il=40users.sf.net>
      8 Author: Andrew Morton <akpm=40linux-foundation.org>
      8 Author: Artem Bityutskiy <artem.bityutskiy=40linux.intel.com>
      8 Author: Dan Williams <dan.j.williams=40intel.com>
      7 Author: Aditya Kali <adityakali=40google.com>
      7 Author: Al Viro <viro=40ZenIV.linux.org.uk>
      7 Author: Alex Tomas <alex=40clusterfs.com>
      7 Author: Arnd Bergmann <arnd=40arndb.de>
      7 Author: Colin Ian King <colin.king=40canonical.com>
      7 Author: Dave Jiang <dave.jiang=40intel.com>
      7 Author: Hugh Dickins <hugh=40veritas.com>
      7 Author: Kazuya Mio <k-mio=40sx.jp.nec.com>
      7 Author: Toshiyuki Okajima <toshi.okajima=40jp.fujitsu.com>
      7 Author: Zheng Liu <gnehzuil.liu=40gmail.com>
      7 Author: zhangyi (F) <yi.zhang=40huawei.com>
      6 Author: Anatol Pomozov <anatol.pomozov=40gmail.com>
      6 Author: Andreas Dilger <adilger=40dilger.ca>
      6 Author: Christoph Lameter <clameter=40sgi.com>
      6 Author: Dan Carpenter <error27=40gmail.com>
      6 Author: Duane Griffin <duaneg=40dghda.com>
      6 Author: Eric W. Biederman <ebiederm=40xmission.com>
      6 Author: Josef Bacik <jbacik=40redhat.com>
      6 Author: Kirill A. Shutemov <kirill.shutemov=40linux.intel.com>
      6 Author: Konstantin Khlebnikov <khlebnikov=40yandex-team.ru>
      6 Author: Li Zefan <lizf=40cn.fujitsu.com>
      6 Author: Mingming <cmm=40us.ibm.com>
      6 Author: Tyson Nottingham <tgnottingham=40gmail.com>
      5 Author: Andrew Morton <akpm=40osdl.org>
      5 Author: Avantika Mathur <mathur=40us.ibm.com>
      5 Author: Chandan Rajendra <chandan=40linux.vnet.ibm.com>
      5 Author: Frank Mayhar <fmayhar=40google.com>
      5 Author: Frederic Bohe <frederic.bohe=40bull.net>
      5 Author: Jose R. Santos <jrs=40us.ibm.com>
      5 Author: Kees Cook <keescook=40chromium.org>
      5 Author: Michal Hocko <mhocko=40suse.com>
      5 Author: Mike Christie <mchristi=40redhat.com>
      5 Author: Omar Sandoval <osandov=40osandov.com>
      5 Author: Peter Zijlstra <a.p.zijlstra=40chello.nl>
      5 Author: Vegard Nossum <vegard.nossum=40oracle.com>
      5 Author: Wu Fengguang <fengguang.wu=40intel.com>
      5 Author: yangerkun <yangerkun=40huawei.com>
      4 Author: Amit Arora <aarora=40in.ibm.com>
      4 Author: Carlos Maiolino <cmaiolino=40redhat.com>
      4 Author: Chengguang Xu <cgxu519=40gmx.com>
      4 Author: Coly Li <i=40coly.li>
      4 Author: David Gstir <david=40sigma-star.at>
      4 Author: Djalal Harouni <tixxdz=40opendz.org>
      4 Author: Hidehiro Kawai <hidehiro.kawai.ez=40hitachi.com>
      4 Author: Jeff Layton <jlayton=40kernel.org>
      4 Author: Josef Bacik <josef=40redhat.com>
      4 Author: Li Xi <pkuelelixi=40gmail.com>
      4 Author: Manish Katiyar <mkatiyar=40gmail.com>
      4 Author: Miao Xie <miaoxie=40huawei.com>
      4 Author: Miklos Szeredi <mszeredi=40redhat.com>
      4 Author: Roel Kluin <roel.kluin=40gmail.com>
      4 Author: Toshi Kani <toshi.kani=40hpe.com>
      4 Author: Uwe Kleine-K=F6nig <u.kleine-koenig=40pengutronix.de>
      4 Author: Valerie Clement <valerie.clement=40bull.net>
      4 Author: Xiaoguang Wang <wangxg.fnst=40cn.fujitsu.com>
      3 Author: Andi Kleen <andi=40firstfloor.org>
      3 Author: Azat Khuzhin <a3at.mail=40gmail.com>
      3 Author: Ben Hutchings <ben=40decadent.org.uk>
      3 Author: Chandan Rajendra <chandan=40linux.ibm.com>
      3 Author: Dave Chinner <dchinner=40redhat.com>
      3 Author: Eric Gouriou <egouriou=40google.com>
      3 Author: Eric Sandeen <sandeen=40sandeen.net>
      3 Author: Gabriel Krisman Bertazi <krisman=40collabora.co.uk>
      3 Author: Gabriel Krisman Bertazi <krisman=40collabora.com>
      3 Author: H Hartley Sweeten <hartleys=40visionengravers.com>
      3 Author: Jaegeuk Kim <jaegeuk=40kernel.org>
      3 Author: Jeff Moyer <jmoyer=40redhat.com>
      3 Author: Jing Zhang <zj.barak=40gmail.com>
      3 Author: Julia Lawall <julia=40diku.dk>
      3 Author: Mathieu Malaterre <malat=40debian.org>
      3 Author: Maurizio Lombardi <mlombard=40redhat.com>
      3 Author: Nick Piggin <npiggin=40kernel.dk>
      3 Author: Nick Piggin <npiggin=40suse.de>
      3 Author: Nicolai Stange <nicstange=40gmail.com>
      3 Author: Nikolay Borisov <nborisov=40suse.com>
      3 Author: Pekka Enberg <penberg=40cs.helsinki.fi>
      3 Author: Peng Tao <bergwolf=40gmail.com>
      3 Author: Randy Dunlap <randy.dunlap=40oracle.com>
      3 Author: Rasmus Villemoes <linux=40rasmusvillemoes.dk>
      3 Author: Riccardo Schirone <sirmy15=40gmail.com>
      3 Author: Robin Dong <hao.bigrat=40gmail.com>
      3 Author: Thiemo Nagel <thiemo.nagel=40ph.tum.de>
      3 Author: Wei Yongjun <yongjun_wei=40trendmicro.com.cn>
      3 Author: jon ernst <jonernst07=40gmail.com>
      2 Author: Adam Buchbinder <adam.buchbinder=40gmail.com>
      2 Author: Alexander Beregalov <a.beregalov=40gmail.com>
      2 Author: Alexandre Ratchov <alexandre.ratchov=40bull.net>
      2 Author: Andi Kleen <ak=40linux.intel.com>
      2 Author: Andi Kleen <ak=40suse.de>
      2 Author: Andreas Dilger <adilger=40clusterfs.com>
      2 Author: Andreas Dilger <adilger=40sun.com>
      2 Author: Andreas Dilger <andreas.dilger=40intel.com>
      2 Author: Andreas Gruenbacher <agruen=40suse.de>
      2 Author: Andrey Sidorov <qrxd43=40motorola.com>
      2 Author: Andr=E9 Goddard Rosa <andre.goddard=40gmail.com>
      2 Author: Ashish Sangwan <a.sangwan=40samsung.com>
      2 Author: Ashish Sangwan <ashishsangwan2=40gmail.com>
      2 Author: Badari Pulavarty <pbadari=40us.ibm.com>
      2 Author: Bernd Schubert <bernd.schubert=40itwm.fraunhofer.de>
      2 Author: Boaz Harrosh <boaz=40plexistor.com>
      2 Author: Chao Yu <chao=40kernel.org>
      2 Author: Coly Li <coyli=40suse.de>
      2 Author: Dan Ehrenberg <dehrenberg=40google.com>
      2 Author: Daniel Mack <daniel=40caiaq.de>
      2 Author: Dave Hansen <haveblue=40us.ibm.com>
      2 Author: Dave Kleikamp <shaggy=40austin.ibm.com>
      2 Author: Deepa Dinamani <deepa.kernel=40gmail.com>
      2 Author: Dennis Zhou <dennis=40kernel.org>
      2 Author: Dmitry Monakhov <dmonakhov=40sw.ru>
      2 Author: Eric Paris <eparis=40redhat.com>
      2 Author: Eryu Guan <eguan=40redhat.com>
      2 Author: Fengguang Wu <wfg=40mail.ustc.edu.cn>
      2 Author: Goldwyn Rodrigues <rgoldwyn=40suse.com>
      2 Author: Herbert Xu <herbert=40gondor.apana.org.au>
      2 Author: Hisashi Hifumi <hifumi.hisashi=40oss.ntt.co.jp>
      2 Author: Ingo Molnar <mingo=40kernel.org>
      2 Author: Jakub Wilk <jwilk=40jwilk.net>
      2 Author: Jan Blunck <jblunck=40infradead.org>
      2 Author: Jan Blunck <jblunck=40suse.de>
      2 Author: Jens Axboe <axboe=40fb.com>
      2 Author: Jens Axboe <axboe=40kernel.dk>
      2 Author: Jens Axboe <jaxboe=40fusionio.com>
      2 Author: Jens Axboe <jens.axboe=40oracle.com>
      2 Author: Jie Liu <jeff.liu=40oracle.com>
      2 Author: Kalpak Shah <kalpak=40clusterfs.com>
      2 Author: Kent Overstreet <kmo=40daterainc.com>
      2 Author: Khazhismel Kumykov <khazhy=40google.com>
      2 Author: Kirill Tkhai <ktkhai=40virtuozzo.com>
      2 Author: Laurent Navet <laurent.navet=40gmail.com>
      2 Author: Marcin Slusarz <marcin.slusarz=40gmail.com>
      2 Author: Markus Elfring <elfring=40users.sourceforge.net>
      2 Author: Mel Gorman <mgorman=40suse.de>
      2 Author: Mel Gorman <mgorman=40techsingularity.net>
      2 Author: Ming Lei <ming.lei=40canonical.com>
      2 Author: Namhyung Kim <namhyung=40gmail.com>
      2 Author: Nikanth Karthikesan <knikanth=40suse.de>
      2 Author: Nikitas Angelinas <nikitasangelinas=40gmail.com>
      2 Author: Pan Bian <bianpan2016=40163.com>
      2 Author: Paul Bolle <pebolle=40tiscali.nl>
      2 Author: Richard Weinberger <richard=40nod.at>
      2 Author: Roel Kluin <12o3l=40tiscali.nl>
      2 Author: Roman Pen <roman.penyaev=40profitbricks.com>
      2 Author: Salman Qazi <sqazi=40google.com>
      2 Author: Sergey Senozhatsky <sergey.senozhatsky=40gmail.com>
      2 Author: Shaohua Li <shaohua.li=40intel.com>
      2 Author: Solofo Ramangalahy <Solofo.Ramangalahy=40bull.net>
      2 Author: Souptick Joarder <jrdr.linux=40gmail.com>
      2 Author: Thadeu Lima de Souza Cascardo <cascardo=40holoscopio.com>=

      2 Author: Tobias Klauser <tklauser=40distanz.ch>
      2 Author: Vasily Averin <vvs=40sw.ru>
      2 Author: Vivek Haldar <haldar=40google.com>
      2 Author: Wang Sheng-Hui <shhuiw=40gmail.com>
      2 Author: Wei Yongjun <yjwei=40cn.fujitsu.com>
      2 Author: Yu Jian <yujian=40whamcloud.com>
      2 Author: Zhang Zhen <zhenzhang.zhang=40huawei.com>
      1 Author: Aaro Koskinen <aaro.koskinen=40nokia.com>
      1 Author: Adam Borowski <kilobyte=40angband.pl>
      1 Author: Adrian Bunk <bunk=40kernel.org>
      1 Author: Adrian Bunk <bunk=40stusta.de>
      1 Author: Aihua Zhang <zhangaihua1=40huawei.com>
      1 Author: Akria Fujita <a-fujita=40rs.jp.nec.com>
      1 Author: Alan Cox <alan=40linux.intel.com>
      1 Author: Ales Novak <alnovak=40suse.cz>
      1 Author: Alessio Igor Bogani <abogani=40texware.it>
      1 Author: Alexander V. Lukyanov <lav=40netis.ru>
      1 Author: Alexey Khoroshilov <khoroshilov=40ispras.ru>
      1 Author: Amerigo Wang <amwang=40redhat.com>
      1 Author: Amir G <amir73il=40users.sourceforge.net>
      1 Author: Anand Gadiyar <gadiyar=40ti.com>
      1 Author: Andi Shyti <andi=40etezian.org>
      1 Author: Andrea Arcangeli <aarcange=40redhat.com>
      1 Author: Andreas Dilger <adilger=40whamcloud.com>
      1 Author: Andreas Schlick <schlick=40lavabit.com>
      1 Author: Andrew Perepechko <andrew.perepechko=40seagate.com>
      1 Author: Andrey Savochkin <saw=40sw.ru>
      1 Author: Andrey Tsyvarev <tsyvarev=40ispras.ru>
      1 Author: Andries E. Brouwer <Andries.Brouwer=40cwi.nl>
      1 Author: Andy Leiserson <andy=40leiserson.org>
      1 Author: Andy Lutomirski <luto=40amacapital.net>
      1 Author: Andy Lutomirski <luto=40kernel.org>
      1 Author: Andy Shevchenko <andriy.shevchenko=40linux.intel.com>
      1 Author: Aneesh Kumar K.V <aneesh.kumar=40gmail.com>
      1 Author: Anton Protopopov <a.s.protopopov=40gmail.com>
      1 Author: Arjan van de Ven <arjan=40linux.intel.com>
      1 Author: Artem Blagodarenko <artem.blagodarenko=40gmail.com>
      1 Author: Barret Rhoden <brho=40google.com>
      1 Author: Bartlomiej Zolnierkiewicz <bzolnier=40gmail.com>
      1 Author: Benoit Boissinot <benoit.boissinot=40ens-lyon.org>
      1 Author: Bobi Jam <bobijam=40whamcloud.com>
      1 Author: Borislav Petkov <bbpetkov=40yahoo.de>
      1 Author: BoxiLiu <lewis.liulei=40huawei.com>
      1 Author: Brian Foster <bfoster=40redhat.com>
      1 Author: Bryan Donlan <bdonlan=40gmail.com>
      1 Author: Chanho Park <parkch98=40gmail.com>
      1 Author: Chen Gang <gang.chen.5i5j=40gmail.com>
      1 Author: Chen Gang <gang.chen=40asianux.com>
      1 Author: Christian Borntraeger <borntraeger=40de.ibm.com>
      1 Author: Christoph Lameter <cl=40linux-foundation.org>
      1 Author: Christoph Lameter <cl=40linux.com>
      1 Author: Chuck Ebbert <cebbert=40redhat.com>
      1 Author: Cody P Schafer <cody=40linux.vnet.ibm.com>
      1 Author: Coly Li <colyli=40gmail.com>
      1 Author: Cong Ding <dinggnu=40gmail.com>
      1 Author: Cyrill Gorcunov <gorcunov=40gmail.com>
      1 Author: Damien Guibouret <damien.guibouret=40partition-saving.com=
>
      1 Author: Dan Magenheimer <dan.magenheimer=40oracle.com>
      1 Author: Dave Jones <davej=40redhat.com>
      1 Author: David Moore <dmoorefo=40gmail.com>
      1 Author: David Turner <novalis=40novalis.org>
      1 Author: David Windsor <dave=40nullcore.net>
      1 Author: Davide Italiano <dccitaliano=40gmail.com>
      1 Author: Debabrata Banerjee <dbanerje=40akamai.com>
      1 Author: Denis V. Lunev <den=40openvz.org>
      1 Author: Dennis Zhou (Facebook) <dennisszhou=40gmail.com>
      1 Author: Dmitri Monakho <dmonakhov=40openvz.org>
      1 Author: Dmitriy Monakhov <dmonakhov=40openvz.org>
      1 Author: Dmitriy Monakhov <dmonakhov=40sw.ru>
      1 Author: Dmitry Mishin <dim=40openvz.org>
      1 Author: Dr. Tilmann Bubeck <t.bubeck=40reinform.de>
      1 Author: Eldad Zack <eldad=40fogrefinery.com>
      1 Author: Emese Revfy <re.emese=40gmail.com>
      1 Author: Emoly Liu <emoly.liu=40intel.com>
      1 Author: Eric Dumazet <dada1=40cosmosbay.com>
      1 Author: Eric Engestrom <eric.engestrom=40imgtec.com>
      1 Author: Eric Sesterhenn <snakebyte=40gmx.de>
      1 Author: Ernesto A. Fern=E1ndez <ernesto.mnd.fernandez=40gmail.com=
>
      1 Author: Eugene Shatokhin <eugene.shatokhin=40rosalab.ru>
      1 Author: Fabrice Jouhaud <yargil=40free.fr>
      1 Author: Fan Yong <yong.fan=40whamcloud.com>
      1 Author: Feng Tang <feng.tang=40intel.com>
      1 Author: Fengguang Wu <fengguang.wu=40gmail.com>
      1 Author: Forrest Liu <forrestl=40synology.com>
      1 Author: From: Thiemo Nagel <thiemo.nagel=40ph.tum.de>
      1 Author: Geert Uytterhoeven <geert+renesas=40glider.be>
      1 Author: Geliang Tang <geliangtang=40163.com>
      1 Author: Giedrius Rekasius <giedrius.rekasius=40gmail.com>
      1 Author: Gioh Kim <gioh.kim=40lge.com>
      1 Author: Girish Shilamkar <girish=40clusterfs.com>
      1 Author: Goffredo Baroncelli <kreijack=40inwind.it>
      1 Author: Greg Harm <gharm=40google.com>
      1 Author: Greg Kroah-Hartman <gregkh=40linuxfoundation.org>
      1 Author: Gustavo A. R. Silva <gustavo=40embeddedor.com>
      1 Author: Haibo Liu <HaiboLiu6=40gmai.com>
      1 Author: HaiboLiu <HaiboLiu6=40gmail.com>
      1 Author: Haogang Chen <haogangchen=40gmail.com>
      1 Author: Harshad Shirwadkar <harshads=40google.com>
      1 Author: Harvey Harrison <harvey.harrison=40gmail.com>
      1 Author: Heiko Carstens <heiko.carstens=40de.ibm.com>
      1 Author: Herton Ronaldo Krzesinski <herton.krzesinski=40canonical.=
com>
      1 Author: Hiroshi Shimamoto <h-shimamoto=40ct.jp.nec.com>
      1 Author: Huaitong Han <huaitong.han=40intel.com>
      1 Author: Huang Weiyi <weiyi.huang=40gmail.com>
      1 Author: Hugh Dickins <hughd=40google.com>
      1 Author: Ingo Molnar <mingo=40elte.hu>
      1 Author: Insu Yun <wuninsu=40gmail.com>
      1 Author: J. Bruce Fields <bfields=40redhat.com>
      1 Author: Jan Mrazek <email=40honzamrazek.cz>
      1 Author: Jason A. Donenfeld <Jason=40zx2c4.com>
      1 Author: Jason Yan <yanaijie=40huawei.com>
      1 Author: Jean Delvare <jdelvare=40suse.de>
      1 Author: Jean Delvare <khali=40linux-fr.org>
      1 Author: Jean Noel Cordenner <jean-noel.cordenner=40bull.net>
      1 Author: Jeremy Cline <jcline=40redhat.com>
      1 Author: Jerry Lee <jerrylee=40qnap.com>
      1 Author: Jesper Dangaard Brouer <hawk=40comx.dk>
      1 Author: Jesper Juhl <jj=40chaosbits.net>
      1 Author: Jiri Slaby <jslaby=40suse.cz>
      1 Author: Jiufei Xue <jiufei.xue=40linux.alibaba.com>
      1 Author: Johann Lombardi <johann.lombardi=40bull.net>
      1 Author: Johann Lombardi <johann=40Sun.COM>
      1 Author: Johann Lombardi <johann=40whamcloud.com>
      1 Author: Johannes Weiner <hannes=40cmpxchg.org>
      1 Author: John Stultz <john.stultz=40linaro.org>
      1 Author: Jon Derrick <jonathan.derrick=40intel.com>
      1 Author: Jon Ernst <jonernst07=40gmx.com>
      1 Author: Josef =22Jeff=22 Sipek <jsipek=40cs.sunysb.edu>
      1 Author: Josef 'Jeff' Sipek <jsipek=40cs.sunysb.edu>
      1 Author: Josef Bacik <jbacik=40fb.com>
      1 Author: Julia Lawall <Julia.Lawall=40lip6.fr>
      1 Author: Jun Piao <piaojun=40huawei.com>
      1 Author: Junho Ryu <jayr=40google.com>
      1 Author: Junichi Uekawa <uekawa=40google.com>
      1 Author: Justin P. Mattock <justinmattock=40gmail.com>
      1 Author: Kaho Ng <ngkaho1234=40gmail.com>
      1 Author: Kalpak Shah <kalpak.shah=40sun.com>
      1 Author: Kent Overstreet <kent.overstreet=40gmail.com>
      1 Author: Kent Overstreet <koverstreet=40google.com>
      1 Author: Kimberly Brown <kimbrownkd=40gmail.com>
      1 Author: Kirill Korotaev <dev=40openvz.org>
      1 Author: Konstantin Khlebnikov <khlebnikov=40openvz.org>
      1 Author: Lachlan McIlroy <lmcilroy=40redhat.com>
      1 Author: Laurent Vivier <Laurent.Vivier=40bull.net>
      1 Author: Leonard Michlmayr <leonard.michlmayr=40gmail.com>
      1 Author: Li Dongyang <dongyangli=40ddn.com>
      1 Author: Linus Torvalds <torvalds=40woody.linux-foundation.org>
      1 Author: Liu Song <liu.song11=40zte.com.cn>
      1 Author: Liu Xiang <liu.xiang6=40zte.com.cn>
      1 Author: Lucas De Marchi <lucas.demarchi=40profusion.mobi>
      1 Author: Luis R. Rodriguez <mcgrof=40kernel.org>
      1 Author: Maarten ter Huurne <maarten=40treewalker.org>
      1 Author: Maciej Żenczykowski <zenczykowski=40gmail.com>
      1 Author: Maninder Singh <maninder1.s=40samsung.com>
      1 Author: Mariusz Kozlowski <m.kozlowski=40tuxland.pl>
      1 Author: Markus Rechberger <Markus.Rechberger=40amd.com>
      1 Author: Markus Trippelsdorf <markus=40trippelsdorf.de>
      1 Author: Martin K. Petersen <martin.petersen=40oracle.com>
      1 Author: Masahiro Yamada <yamada.masahiro=40socionext.com>
      1 Author: Mathias Krause <minipli=40googlemail.com>
      1 Author: Mathieu Desnoyers <mathieu.desnoyers=40polymtl.ca>
      1 Author: Matt LaPlante <kernel1=40cyberdogtech.com>
      1 Author: Matthew Garrett <mjg59=40google.com>
      1 Author: Maxim Patlasov <MPatlasov=40parallels.com>
      1 Author: Maxim Patlasov <maxim.patlasov=40gmail.com>
      1 Author: Miao Xie <miaox=40cn.fujitsu.com>
      1 Author: Michael Callahan <michaelcallahan=40fb.com>
      1 Author: Michael Tokarev <mjt=40tls.msk.ru>
      1 Author: Michal Hocko <mhocko=40suse.cz>
      1 Author: Miguel Ojeda <miguel.ojeda.sandonis=40gmail.com>
      1 Author: Mike Snitzer <snitzer=40gmail.com>
      1 Author: Mikulas Patocka <mikulas=40twibright.com>
      1 Author: Mimi Zohar <zohar=40linux.vnet.ibm.com>
      1 Author: Ming Lei <ming.lei=40redhat.com>
      1 Author: Namjae Jeon <linkinjeon=40gmail.com>
      1 Author: Nicolas Kaiser <nikai=40nikai.net>
      1 Author: Nikolay Borisov <kernel=40kyup.com>
      1 Author: Niu Yawei <yawei.niu=40gmail.com>
      1 Author: Pankaj Gupta <pagupta=40redhat.com>
      1 Author: Patrick J. LoPresti <lopresti=40gmail.com>
      1 Author: Patrick Palka <patrick=40parcs.ath.cx>
      1 Author: Paul Gortmaker <paul.gortmaker=40windriver.com>
      1 Author: Paul Mackerras <paulus=40samba.org>
      1 Author: Paul Mundt <lethal=40linux-sh.org>
      1 Author: Paul Taysom <taysom=40chromium.org>
      1 Author: Peter Huewe <peterhuewe=40gmx.de>
      1 Author: Peter Zijlstra <peterz=40infradead.org>
      1 Author: Petros Koutoupis <petros=40petroskoutoupis.com>
      1 Author: Philippe De Muyter <phdm=40macqel.be>
      1 Author: Piotr Sarna <p.sarna=40partner.samsung.com>
      1 Author: Pranay Kr. Srivastava <pranjas=40gmail.com>
      1 Author: Rakesh Pandit <rakesh=40tuxera.com>
      1 Author: Randy Dodgen <dodgen=40google.com>
      1 Author: Randy Dunlap <rdunlap=40infradead.org>
      1 Author: Richard Kennedy <richard=40rsk.demon.co.uk>
      1 Author: Robert P. J. Day <rpjday=40mindspring.com>
      1 Author: Ross Zwisler <zwisler=40chromium.org>
      1 Author: Rusty Russell <rusty=40rustcorp.com.au>
      1 Author: Sachin Kamat <sachin.kamat=40linaro.org>
      1 Author: Sahitya Tummala <stummala=40codeaurora.org>
      1 Author: Santosh Nayak <santoshprasadnayak=40gmail.com>
      1 Author: Satyam Sharma <ssatyam=40cse.iitk.ac.in>
      1 Author: Sean Fu <fxinrong=40gmail.com>
      1 Author: Serge E. Hallyn <serge=40hallyn.com>
      1 Author: Sergey Karamov <skaramov=40google.com>
      1 Author: Seth Forshee <seth.forshee=40canonical.com>
      1 Author: Seunghun Lee <waydi1=40gmail.com>
      1 Author: Sheng Yong <shengyong1=40huawei.com>
      1 Author: Shi Siyuan <shisiyuan=40xiaomi.com>
      1 Author: Simon Ruderich <simon=40ruderich.org>
      1 Author: Solofo.Ramangalahy=40bull.net <>
      1 Author: Sriram Rajagopalan <sriramr=40arista.com>
      1 Author: Stephen Hemminger <shemminger=40vyatta.com>
      1 Author: Stephen Hemminger <stephen=40networkplumber.org>
      1 Author: Steven Liu <lingjiujianke=40gmail.com>
      1 Author: Steven Whitehouse <swhiteho=40redhat.com>
      1 Author: Stoyan Gaydarov <stoyboyker=40gmail.com>
      1 Author: Suparna Bhattacharya <suparna=40in.ibm.com>
      1 Author: Surbhi Palande <surbhi.palande=40canonical.com>
      1 Author: T Makphaibulchoke <tmac=40hp.com>
      1 Author: Takashi Sato <sho=40tnes.nec.co.jp>
      1 Author: Takashi Sato <t-sato=40yk.jp.nec.com>
      1 Author: Tao Ma <tao.ma=40oracle.com>
      1 Author: Theodore Tso <tytso=40MIT.EDU>
      1 Author: Thomas Gleixner <tglx=40linutronix.de>
      1 Author: Tiger Yang <tiger.yang=40oracle.com>
      1 Author: Tim Schmielau <tim=40physik3.uni-rostock.de>
      1 Author: Utako Kusaka <u-kusaka=40wm.jp.nec.com>
      1 Author: Vahram Martirosyan <vmartirosyan=40gmail.com>
      1 Author: Valerie Aurora <val=40vaaconsulting.com>
      1 Author: Venkatesh Pallipadi <venkatesh.pallipadi=40intel.com>
      1 Author: Vignesh Babu <vignesh.babu=40wipro.com>
      1 Author: Vincent Minet <vincent=40vincent-minet.net>
      1 Author: Viresh Kumar <viresh.kumar=40linaro.org>
      1 Author: Vladimir Davydov <vdavydov.dev=40gmail.com>
      1 Author: Wang Sheng-Hui <crosslonelyover=40gmail.com>
      1 Author: Wang Shilong <wangshilong1991=40gmail.com>
      1 Author: Wang Shilong <wangsl-fnst=40cn.fujitsu.com>
      1 Author: Wei Yuan <weiyuan.wei=40huawei.com>
      1 Author: Xi Wang <xi.wang=40gmail.com>
      1 Author: Xiaoguang Wang <xiaoguang.wang=40linux.alibaba.com>
      1 Author: Xu Cang <cangxumu=40gmail.com>
      1 Author: Yan, Zheng <zheng.z.yan=40intel.com>
      1 Author: Yang Ruirui <ruirui.r.yang=40tieto.com>
      1 Author: Yaowei Bai <bywxiaobai=40163.com>
      1 Author: Yasunori Goto <y-goto=40jp.fujitsu.com>
      1 Author: Younger Liu <younger.liucn=40gmail.com>
      1 Author: ZhangXiaoxu <zhangxiaoxu5=40huawei.com>
      1 Author: Zhao Hongjiang <zhaohongjiang=40huawei.com>
      1 Author: Zhi Yong Wu <wuzhy=40linux.vnet.ibm.com>
      1 Author: Zhouyi Zhou <zhouzhouyi=40gmail.com>
      1 Author: boxi liu <boxi10liu=40gmail.com>
      1 Author: gmail <yngsion=40gmail.com>
      1 Author: harshads <harshads=40google.com>
      1 Author: jiayingz=40google.com (Jiaying Zhang) <>
      1 Author: jon ernst <jonernst07=40gmx.com>
      1 Author: liang xie <xieliang007=40gmail.com>
      1 Author: piaojun <piaojun=40huawei.com>
      1 Author: ruippan (潘睿) <ruippan=40tencent.com>
      1 Author: vignesh babu <vignesh.babu=40wipro.com>
      1 Author: vikram.jadhav07 <vikramjadhavpucsd2007=40gmail.com>
      1 Author: wangguang <wang.guang55=40zte.com.cn>
      1 Author: yalin wang <yalin.wang2010=40gmail.com>
      1 Author: zhangjs <zachary=40baishancloud.com>
      1 Author: zhenwei.pi <zhenwei.pi=40youruncloud.com>
      1 Author: zhong jiang <zhongjiang=40huawei.com>
      1 Author: zilong.liu <liuziloong=40gmail.com>



--==_Exmh_1567247121_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWpLEQdmEQWDXROgAQJr1w/9EWo+t6TnEWvi8I6AJ/eFv7giSXZLxDqA
aaQSB31X7yBlwdO4v7Sg13fJgNV+djNU0FB06obaXqPzWL63Y0ZkwLBYfNw594qE
IfIWH++PyXo4rRaamOt7luoZyQuou/7HO9SLjGCVcOn0gnZpGr5Tb+24Wy5789An
KI7mgRFm91dsPiMudIQW7iAdOFOX+yLrO0hUZPcwIdj7j+9+EXNqInnKfM0W70hT
lwbqX8vEoszvTdWLJ16pxgEvHHoeGHoEy5l2PWIZYoGMkT1S52+QwuxZu04gSpKc
Fdne/NXIXMB6/iskS27Am5C2Iv4zzatGZm49ksyoeB8SALKsvXoQvHiEZ4rj4v2G
UDFXMUJp28XDY0kxemc2yC6ullJhzjBKnPhD7Xo12s3zZip6NAJ9mGqlON4HBktc
4UDDDpx7MHQcl16sefYfytlmj/FiPt1D/xmMUT5wRMtAzcIE6zaKJx42/aZEpbxC
7cP50Mq3WKMSxziBALZt3vDus7z4KMbq831qLMAF1R1wC79InPUDaWwhUVUHeJIG
GLq1OCoLoy4091kozfftpoKK9YwvtchQ/coL/fE/eHwZHhM/1oi288GRa+IM3976
8PpYmhLoee5u9QWkyCMiuvMnI5msyiuw9IJmd67RAzIQYCXDdPFJDdzQrWYZwsgQ
n4v69ErSUYg=
=Ejg0
-----END PGP SIGNATURE-----

--==_Exmh_1567247121_4251P--
