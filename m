Return-Path: <linux-fsdevel+bounces-794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4EA7D0440
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C436DB21270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5433FE28;
	Thu, 19 Oct 2023 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTE3SHMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246D8F54
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 21:55:50 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1BB137
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:55:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae2f8bf865so135102b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697752546; x=1698357346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x7fNAgUclW/dZ4C+FeTd/4bXpjT6wASJvd5Y6Sz4mA=;
        b=jTE3SHMz01xzXOensSAUJynCpEfA70ZE8uOuQDgusVhItT6aHNDvtysTPGwNmHKaT+
         SHRLuHBg4LdgCwWxbDGG+t0T4o/7A4YcEqMD5cxIIv+NPnfgyiDn5uvkelwxnj61eIrp
         lr1nNHEEPw9gDOVYXNQaeZR7cMdPtXoQmkpuvnqFN0PSegK2Pe0sCR7k+FLkXGaIs14I
         5/el+oz3f6gxIzqx/wvIKCqHjLOoFULZqpDy8QZMRwOD23vf2N2pZu7BKTYOoNmZn2bB
         IHNv4+xR/bIn5bYVUQMKcu0eIK9Pk3tll8HuuWE043H4z4o1fFFi8gMtr8BEeKqzqPEZ
         VWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752546; x=1698357346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x7fNAgUclW/dZ4C+FeTd/4bXpjT6wASJvd5Y6Sz4mA=;
        b=gVTSNZAR+DQSGIkl/0XYjgBJAJaB2NV4PiCKNpYNcjavxmFmM/VDyG6YZYRjmDzgi/
         gSeLW9gj78V8V/QAlQGe0acy8Ku5/+8fTqWDjClmUwuxiFVVvN9u7JI7Z3ti6ty9SwvH
         PmQvhh91zAzFvqHJXHboT6xT8LwmGnGR8ddCLYdcAd4DnZhmuhfgBQVQyhVexISoH/fm
         jbuNjdnDVA0LLqBE5i5SNT4Rd+7hGZIV3u2MljWjbSGfNoYpupUX+dhSs/73yRWsOqOK
         vvzZp1Izxx5QzpP6yejbO89AuzCLlFp5oouw+TK7LoAj7/7+2Fz96Jv+OI9UZ29Jfz18
         VJmg==
X-Gm-Message-State: AOJu0Yzj1q7+cp+hoV3vPXnyh0NQ6aai2TtWczlyxnVy7QMdxhQFphuT
	rCXrY6h5dLijR/j2Pgwg+rdM7/e61MYIyltsvRA5AQ==
X-Google-Smtp-Source: AGHT+IGYe5PPblYRslLf/6Giq5qmRtofbqAqD6yTJcwBO8AmHbJNL6wScpZJknUFQpZpPCr8BQbJVOqomYJTWvZPT7g=
X-Received: by 2002:aca:d0d:0:b0:3b2:e649:b5fb with SMTP id
 13-20020aca0d0d000000b003b2e649b5fbmr95719oin.15.1697752546123; Thu, 19 Oct
 2023 14:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-3-surenb@google.com> <202310180338.zTpcYECK-lkp@intel.com>
In-Reply-To: <202310180338.zTpcYECK-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Oct 2023 14:55:31 -0700
Message-ID: <CAJuCfpGJqzuJqfH42=f5LXxkf4uCNmUUh2zXyzodczP29O6_hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: kernel test robot <lkp@intel.com>
Cc: akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 12:40=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Suren,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on next-20231017]
> [cannot apply to linus/master v6.6-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan=
/mm-rmap-support-move-to-different-root-anon_vma-in-folio_move_anon_rmap/20=
231009-144552
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20231009064230.2952396-3-surenb%=
40google.com
> patch subject: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
> config: i386-randconfig-141-20231017 (https://download.01.org/0day-ci/arc=
hive/20231018/202310180338.zTpcYECK-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231018/202310180338=
.zTpcYECK-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310180338.zTpcYECK-lkp=
@intel.com/
>
> smatch warnings:
> mm/userfaultfd.c:1380 remap_pages() warn: unsigned 'src_start + len - src=
_addr' is never less than zero.

Hmm. I think this warning is correct only when
CONFIG_TRANSPARENT_HUGEPAGE=3Dn. I guess I'll have to add an "ifdef
CONFIG_TRANSPARENT_HUGEPAGE" here after all, which lets us move these
checks before locking PTL.

>
> vim +1380 mm/userfaultfd.c
>
>   1195
>   1196  /**
>   1197   * remap_pages - remap arbitrary anonymous pages of an existing v=
ma
>   1198   * @dst_start: start of the destination virtual memory range
>   1199   * @src_start: start of the source virtual memory range
>   1200   * @len: length of the virtual memory range
>   1201   *
>   1202   * remap_pages() remaps arbitrary anonymous pages atomically in z=
ero
>   1203   * copy. It only works on non shared anonymous pages because thos=
e can
>   1204   * be relocated without generating non linear anon_vmas in the rm=
ap
>   1205   * code.
>   1206   *
>   1207   * It provides a zero copy mechanism to handle userspace page fau=
lts.
>   1208   * The source vma pages should have mapcount =3D=3D 1, which can =
be
>   1209   * enforced by using madvise(MADV_DONTFORK) on src vma.
>   1210   *
>   1211   * The thread receiving the page during the userland page fault
>   1212   * will receive the faulting page in the source vma through the n=
etwork,
>   1213   * storage or any other I/O device (MADV_DONTFORK in the source v=
ma
>   1214   * avoids remap_pages() to fail with -EBUSY if the process forks =
before
>   1215   * remap_pages() is called), then it will call remap_pages() to m=
ap the
>   1216   * page in the faulting address in the destination vma.
>   1217   *
>   1218   * This userfaultfd command works purely via pagetables, so it's =
the
>   1219   * most efficient way to move physical non shared anonymous pages
>   1220   * across different virtual addresses. Unlike mremap()/mmap()/mun=
map()
>   1221   * it does not create any new vmas. The mapping in the destinatio=
n
>   1222   * address is atomic.
>   1223   *
>   1224   * It only works if the vma protection bits are identical from th=
e
>   1225   * source and destination vma.
>   1226   *
>   1227   * It can remap non shared anonymous pages within the same vma to=
o.
>   1228   *
>   1229   * If the source virtual memory range has any unmapped holes, or =
if
>   1230   * the destination virtual memory range is not a whole unmapped h=
ole,
>   1231   * remap_pages() will fail respectively with -ENOENT or -EEXIST. =
This
>   1232   * provides a very strict behavior to avoid any chance of memory
>   1233   * corruption going unnoticed if there are userland race conditio=
ns.
>   1234   * Only one thread should resolve the userland page fault at any =
given
>   1235   * time for any given faulting address. This means that if two th=
reads
>   1236   * try to both call remap_pages() on the same destination address=
 at the
>   1237   * same time, the second thread will get an explicit error from t=
his
>   1238   * command.
>   1239   *
>   1240   * The command retval will return "len" is successful. The comman=
d
>   1241   * however can be interrupted by fatal signals or errors. If
>   1242   * interrupted it will return the number of bytes successfully
>   1243   * remapped before the interruption if any, or the negative error=
 if
>   1244   * none. It will never return zero. Either it will return an erro=
r or
>   1245   * an amount of bytes successfully moved. If the retval reports a
>   1246   * "short" remap, the remap_pages() command should be repeated by
>   1247   * userland with src+retval, dst+reval, len-retval if it wants to=
 know
>   1248   * about the error that interrupted it.
>   1249   *
>   1250   * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
>   1251   * prevent -ENOENT errors to materialize if there are holes in th=
e
>   1252   * source virtual range that is being remapped. The holes will be
>   1253   * accounted as successfully remapped in the retval of the
>   1254   * command. This is mostly useful to remap hugepage naturally ali=
gned
>   1255   * virtual regions without knowing if there are transparent hugep=
age
>   1256   * in the regions or not, but preventing the risk of having to sp=
lit
>   1257   * the hugepmd during the remap.
>   1258   *
>   1259   * If there's any rmap walk that is taking the anon_vma locks wit=
hout
>   1260   * first obtaining the folio lock (the only current instance is
>   1261   * folio_referenced), they will have to verify if the folio->mapp=
ing
>   1262   * has changed after taking the anon_vma lock. If it changed they
>   1263   * should release the lock and retry obtaining a new anon_vma, be=
cause
>   1264   * it means the anon_vma was changed by remap_pages() before the =
lock
>   1265   * could be obtained. This is the only additional complexity adde=
d to
>   1266   * the rmap code to provide this anonymous page remapping functio=
nality.
>   1267   */
>   1268  ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *s=
rc_mm,
>   1269                      unsigned long dst_start, unsigned long src_st=
art,
>   1270                      unsigned long len, __u64 mode)
>   1271  {
>   1272          struct vm_area_struct *src_vma, *dst_vma;
>   1273          unsigned long src_addr, dst_addr;
>   1274          pmd_t *src_pmd, *dst_pmd;
>   1275          long err =3D -EINVAL;
>   1276          ssize_t moved =3D 0;
>   1277
>   1278          /*
>   1279           * Sanitize the command parameters:
>   1280           */
>   1281          BUG_ON(src_start & ~PAGE_MASK);
>   1282          BUG_ON(dst_start & ~PAGE_MASK);
>   1283          BUG_ON(len & ~PAGE_MASK);
>   1284
>   1285          /* Does the address range wrap, or is the span zero-sized=
? */
>   1286          BUG_ON(src_start + len <=3D src_start);
>   1287          BUG_ON(dst_start + len <=3D dst_start);
>   1288
>   1289          /*
>   1290           * Because these are read sempahores there's no risk of l=
ock
>   1291           * inversion.
>   1292           */
>   1293          mmap_read_lock(dst_mm);
>   1294          if (dst_mm !=3D src_mm)
>   1295                  mmap_read_lock(src_mm);
>   1296
>   1297          /*
>   1298           * Make sure the vma is not shared, that the src and dst =
remap
>   1299           * ranges are both valid and fully within a single existi=
ng
>   1300           * vma.
>   1301           */
>   1302          src_vma =3D find_vma(src_mm, src_start);
>   1303          if (!src_vma || (src_vma->vm_flags & VM_SHARED))
>   1304                  goto out;
>   1305          if (src_start < src_vma->vm_start ||
>   1306              src_start + len > src_vma->vm_end)
>   1307                  goto out;
>   1308
>   1309          dst_vma =3D find_vma(dst_mm, dst_start);
>   1310          if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
>   1311                  goto out;
>   1312          if (dst_start < dst_vma->vm_start ||
>   1313              dst_start + len > dst_vma->vm_end)
>   1314                  goto out;
>   1315
>   1316          err =3D validate_remap_areas(src_vma, dst_vma);
>   1317          if (err)
>   1318                  goto out;
>   1319
>   1320          for (src_addr =3D src_start, dst_addr =3D dst_start;
>   1321               src_addr < src_start + len;) {
>   1322                  spinlock_t *ptl;
>   1323                  pmd_t dst_pmdval;
>   1324                  unsigned long step_size;
>   1325
>   1326                  BUG_ON(dst_addr >=3D dst_start + len);
>   1327                  /*
>   1328                   * Below works because anonymous area would not h=
ave a
>   1329                   * transparent huge PUD. If file-backed support i=
s added,
>   1330                   * that case would need to be handled here.
>   1331                   */
>   1332                  src_pmd =3D mm_find_pmd(src_mm, src_addr);
>   1333                  if (unlikely(!src_pmd)) {
>   1334                          if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
>   1335                                  err =3D -ENOENT;
>   1336                                  break;
>   1337                          }
>   1338                          src_pmd =3D mm_alloc_pmd(src_mm, src_addr=
);
>   1339                          if (unlikely(!src_pmd)) {
>   1340                                  err =3D -ENOMEM;
>   1341                                  break;
>   1342                          }
>   1343                  }
>   1344                  dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
>   1345                  if (unlikely(!dst_pmd)) {
>   1346                          err =3D -ENOMEM;
>   1347                          break;
>   1348                  }
>   1349
>   1350                  dst_pmdval =3D pmdp_get_lockless(dst_pmd);
>   1351                  /*
>   1352                   * If the dst_pmd is mapped as THP don't override=
 it and just
>   1353                   * be strict. If dst_pmd changes into TPH after t=
his check, the
>   1354                   * remap_pages_huge_pmd() will detect the change =
and retry
>   1355                   * while remap_pages_pte() will detect the change=
 and fail.
>   1356                   */
>   1357                  if (unlikely(pmd_trans_huge(dst_pmdval))) {
>   1358                          err =3D -EEXIST;
>   1359                          break;
>   1360                  }
>   1361
>   1362                  ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
>   1363                  if (ptl) {
>   1364                          if (pmd_devmap(*src_pmd)) {
>   1365                                  spin_unlock(ptl);
>   1366                                  err =3D -ENOENT;
>   1367                                  break;
>   1368                          }
>   1369
>   1370                          /*
>   1371                           * Check if we can move the pmd without
>   1372                           * splitting it. First check the address
>   1373                           * alignment to be the same in src/dst.  =
These
>   1374                           * checks don't actually need the PT lock=
 but
>   1375                           * it's good to do it here to optimize th=
is
>   1376                           * block away at build time if
>   1377                           * CONFIG_TRANSPARENT_HUGEPAGE is not set=
.
>   1378                           */
>   1379                          if ((src_addr & ~HPAGE_PMD_MASK) || (dst_=
addr & ~HPAGE_PMD_MASK) ||
> > 1380                              src_start + len - src_addr < HPAGE_PM=
D_SIZE || !pmd_none(dst_pmdval)) {
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

