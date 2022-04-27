Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF93510E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiD0Btz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbiD0Bty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:49:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9AD49910
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651024004; x=1682560004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MdLhKR3iPWnl3Ay7JNgoR0/piJKLQFs4RnW6vFuQAdo=;
  b=ITphzwtQ45mwDqFjjzHAQnfVy2l67n7QQRDL2/TZx+FY50KpY4pnoSjS
   ETu0rsntkwq9aJN4888Fe2NsZ3uTrCQ6j504Ax4PKklHulWcCwwg2jrsr
   yPH2orD7hl68ukaBse3CpzLXQ+iXnS358CR5hi11p1X8jLhybFRL1srz5
   M/jtp222wtOzLK8lksH5eMI1+VK/6i6DwLjCmMwmGouyDWJJCdBd/uX92
   Bankrazgo55H0reYSTRhMoN50Zh1EmHrJotFW5Ryn3Nso3sekCFY01TPA
   XFDnY1+uyFOGIYHjsIx4xbbfwP9CdEmk7HY/1LlIzs/guhTJPkOC+Twgv
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="303117464"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 09:46:44 +0800
IronPort-SDR: lTKzHANtDJt6if6AcBa+z8IDuKEEYj++kZR+UQKPDGsBig1fiymD7fqp+di+YqyK2e7uCK91rN
 obsC1ktQXCT2SByCQOq0q8qSlnyUKlzTSoW/HAaZ7hPqqHEZ7k/APpnvuNeWFBtyn64GxaeqwH
 aMXD16sR9ixpqmOTRe1idlKhMZkbywGvj84klXvsGZUyD4ZWUzERld81EeXidDG3W1Egyn/p03
 GPAv2Ej1k6kLQcFFwBhp61jiJz3tSrLSm+O0ZfawqGoBbqa5c+NbPGV+GuvLdedtFDXNG0/jCo
 p8oBKwESfjDyjXUKfHDxkG0z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:16:54 -0700
IronPort-SDR: kIJDz80zTgocPQ99M0KhD8OtqRFqepTPyXZuKUqG9bSOFfEFUCD0lNcCEvpHhjcvsysT5TbLZt
 HtU8auIxqbslQwgZgWQOrdTH2kiGSUHJD9lRBInPK1rC82SHzOuJ6RLR7ndIz0aAm1/xMXo5+N
 jlL+6g/RTAhGKV3BTUJa126jgBTnzW1u7Tloqt8QAsyrEQUNwgXFZl3yZSLtWNVaZmitkiXeGm
 h07FN+FsRmgUVDwQduEFuhQ2zeU8EK9p3jdEjnlCq0LKc1seqL5DhQXshZ6mkv94RNiyB7MAe6
 Q1Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:46:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp1nY6vcfz1SVp0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:46:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651024000; x=1653616001; bh=MdLhKR3iPWnl3Ay7JNgoR0/piJKLQFs4RnW
        6vFuQAdo=; b=UbjXvKITtW+c8uqObhMHINutNE6s65wr7ZyR+skvkVhpzM3SBil
        hbcGdVx4JcW9EfZIR4/n0lHtxSmeKPOrmYsBB+nmKmcnWVouAwR1uzIA9YhFpfiz
        KMI8B5bynIvl6lmFqblrcsReLuMfWVOCJ1A4k2MM4kyb5UtlXTqDBYpMsMtGF0cq
        Pq18fv/uSl3DHUxKvRgSqlfsdl1R1/WEZbZ6gNQjsWQAmjuZywyWfOd+GVWtB8ZT
        UV8fcFWI2Skqz2SB3N4pBjrZTdHwzVRh7HdKAIVgHGKbGviZ+6brvZZT7C8QEw7O
        16CCQExeMIyaG69VcpNWoiBoyeqcYEFEsaQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ajh40iatXXoi for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 18:46:40 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp1nQ10FXz1Rvlc;
        Tue, 26 Apr 2022 18:46:33 -0700 (PDT)
Message-ID: <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 10:46:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> The patch series covers the points discussed in November 2021 virtual c=
all
> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> We have covered the Initial agreed requirements in this patchset.
> Patchset borrows Mikulas's token based approach for 2 bdev
> implementation.
>=20
> Overall series supports =E2=80=93
>=20
> 1. Driver
> - NVMe Copy command (single NS), including support in nvme-target (for
>     block and file backend)
>=20
> 2. Block layer
> - Block-generic copy (REQ_COPY flag), with interface accommodating
>     two block-devs, and multi-source/destination interface
> - Emulation, when offload is natively absent
> - dm-linear support (for cases not requiring split)
>=20
> 3. User-interface
> - new ioctl
> - copy_file_range for zonefs
>=20
> 4. In-kernel user
> - dm-kcopyd
> - copy_file_range in zonefs
>=20
> For zonefs copy_file_range - Seems we cannot levearge fstest here. Limi=
ted
> testing is done at this point using a custom application for unit testi=
ng.

https://github.com/westerndigitalcorporation/zonefs-tools

./configure --with-tests
make
sudo make install

Then run tests/zonefs-tests.sh

Adding test case is simple. Just add script files under tests/scripts

I just realized that the README file of this project is not documenting
this. I will update it.

>=20
> Appreciate the inputs on plumbing and how to test this further?
> Perhaps some of it can be discussed during LSF/MM too.
>=20
> [0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=3DzT1=
4mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
>=20
> Changes in v4:
> - added copy_file_range support for zonefs
> - added documentaion about new sysfs entries
> - incorporated review comments on v3
> - minor fixes
>=20
>=20
> Arnav Dawn (2):
>   nvmet: add copy command support for bdev and file ns
>   fs: add support for copy file range in zonefs
>=20
> Nitesh Shetty (7):
>   block: Introduce queue limits for copy-offload support
>   block: Add copy offload support infrastructure
>   block: Introduce a new ioctl for copy
>   block: add emulation for copy
>   nvme: add copy offload support
>   dm: Add support for copy offload.
>   dm: Enable copy offload for dm-linear target
>=20
> SelvaKumar S (1):
>   dm kcopyd: use copy offload support
>=20
>  Documentation/ABI/stable/sysfs-block |  83 +++++++
>  block/blk-lib.c                      | 358 +++++++++++++++++++++++++++
>  block/blk-map.c                      |   2 +-
>  block/blk-settings.c                 |  59 +++++
>  block/blk-sysfs.c                    | 138 +++++++++++
>  block/blk.h                          |   2 +
>  block/ioctl.c                        |  32 +++
>  drivers/md/dm-kcopyd.c               |  55 +++-
>  drivers/md/dm-linear.c               |   1 +
>  drivers/md/dm-table.c                |  45 ++++
>  drivers/md/dm.c                      |   6 +
>  drivers/nvme/host/core.c             | 116 ++++++++-
>  drivers/nvme/host/fc.c               |   4 +
>  drivers/nvme/host/nvme.h             |   7 +
>  drivers/nvme/host/pci.c              |  25 ++
>  drivers/nvme/host/rdma.c             |   6 +
>  drivers/nvme/host/tcp.c              |  14 ++
>  drivers/nvme/host/trace.c            |  19 ++
>  drivers/nvme/target/admin-cmd.c      |   8 +-
>  drivers/nvme/target/io-cmd-bdev.c    |  65 +++++
>  drivers/nvme/target/io-cmd-file.c    |  49 ++++
>  fs/zonefs/super.c                    | 178 ++++++++++++-
>  fs/zonefs/zonefs.h                   |   1 +
>  include/linux/blk_types.h            |  21 ++
>  include/linux/blkdev.h               |  17 ++
>  include/linux/device-mapper.h        |   5 +
>  include/linux/nvme.h                 |  43 +++-
>  include/uapi/linux/fs.h              |  23 ++
>  28 files changed, 1367 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: e7d6987e09a328d4a949701db40ef63fbb970670


--=20
Damien Le Moal
Western Digital Research
