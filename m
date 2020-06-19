Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7C201AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFSTG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 15:06:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19857 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgFSTGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592593582; x=1624129582;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o4ybjphRDBwds/r8RwOdmaCPia164nqaxDbwyz+0IjA=;
  b=r5MLS5TAUm+oGZbnWFP1S/ZT5dae49i1K1W6ON8a3UBshqvT31F+pT/i
   BqIlMTE36Caa6cym11fDzt7Rw1bICeA+tjIOphdO2REVmLP7fsHbGiwog
   WCxgj5KkGudh+JVGjlP5VsmCfVZpEXByp+mp/wIsa3CjXNs1UE92rlKT1
   7/CqWD83pTEnSfbJFtzLdUeKXA2NWty89b52UEFsZ+fZzJsdkC5bBBCzr
   ZT32JcSpjclODvmRQweJmDJYkpwuM1muk/zHyijzbBWAcMUSU1hbLFIbI
   Az0xwCyHS/wuuOO35sa70UtSO53xq6txdIgJ8Mz/iiPsT2t0eHyZPxtf6
   A==;
IronPort-SDR: rdjJVfxRj2Pslwh0kGuHz8yqSYZRNO+1w+rZJh+QcBDri+xCr7Xl6BKLb0EXycCU3cWCUrIWq8
 Kk7TofrQGiZU7rdu51Dfd2G7QtrjZf3Kkq/AmoERTMVuja280mnaEN6/ZDEAuNzHmh4KcaMzT0
 K1d7PtoUN6oGzpb8FmqG8d+IBfHXqFp2DVfRGBH7R5oehp1F43WCg1fJwxgte+fiSM88elAu4K
 vAc4GWv+OPruk5X+1neQdU1/a6BKRwHwCZq4B2FjhUlmfJjiJ9NHsnedpjEUqjX5AM425BVvnE
 H4M=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; 
   d="scan'208";a="140451299"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 03:06:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi5acjv7IGHXIQcq0RUM8FEBrKtpPnR7tp0FI5ZISv4am/xBsqVL7ovumsWp8CR7xHzjYOnATCEb5+uv9TKoLEgkCiy5lbrjZqhI6doaZwdXihFPvcqaQ9kyDXGfa1R6EARjqk6KXPJIFTPgeF7Gwv60zWT9fcEkeF9v2qEbK+ZIWG81yBhLDilBGZFalJMRwulmI1aNkhlTCpE85AGzukPlZs63Goo6nmCUD3c+k1vQhgw/9l9+42/X9gy1ZoUkXyzoRmED4yN35EfY8eKkLhkqhxLyGmes9231pXENBThQe5MZm1TnEMrHQDTFcIFlKJCcj+Hd5IwZZ+VyYtr4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMXwBek720FCYttgLun6XybA+61zlmxPyJkU1+328rI=;
 b=Jl8wvb0vzKdoRBbT5cBLVDiGukdrhGVr7KMZ2ILLASqVm2/nWgvcT9jxIilURSETuDwY9olAtmmgCffDrBq+7pYborEyzVJZ1ijDAB/3rF1l27Pd8oHjAVHgucdeexIZjznQtY36WL1FebNEnmwmv9Vl6BOtGVaVDa+ukUAWK4Ai9J0t7l4ViQvlyHZDhHdu8YY1/R12XAS2P+sp570lVhGg6J32mghMH8G0kE9nCUwsIBndz6WE7sbwnSzQM8Q1mq5M0NY6SDOxesWYNdlFJvda3UCGNebgBbuJD5VjK/scijX/aKkx9yBTn4RV6VSLIbrVMVtL9qNVUGBZWGD4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMXwBek720FCYttgLun6XybA+61zlmxPyJkU1+328rI=;
 b=MPqwEgIw1AKLPzUl9G/WCqPFt+Aln5aNxPNXH2y6AcQx3XWVKhyCn6dK08d5T9J9pVJm1gZ0RVRhz1blnf3MkQLsDOT8DpMHCj5JyE+UJdkK6WqIuXAJd1lvqBGK7oTejKQctG7qQH8XXNgTOJ5s3r/mbwr/+cURfyzMymeTL2k=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6021.namprd04.prod.outlook.com (2603:10b6:a03:e6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Fri, 19 Jun
 2020 19:06:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 19:06:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Thread-Topic: [RFC] Bypass filesystems for reading cached pages
Thread-Index: AQHWRlFoe2caIyYlK0mh4vA1o1hS7w==
Date:   Fri, 19 Jun 2020 19:06:19 +0000
Message-ID: <BYAPR04MB49655EAA09477CB716D39C8986980@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200619155036.GZ8681@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8b3479-c0be-41a7-4600-08d81483d951
x-ms-traffictypediagnostic: BYAPR04MB6021:
x-microsoft-antispam-prvs: <BYAPR04MB6021669CB81FF5420541A18086980@BYAPR04MB6021.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKA1pIByayOJg+tZeJDXMH5r+FoDHM1Fa3jzhHyRonkec/x43omLRBwXxJURAQMmbFqjbSr5+hmiS5QUtZotUqfwc17UJm0x7EqoZnEuMaZNrG3nT1kia2HSkVciq3Jt+W945OLxhPgIrbSWCRQpp+JjVQB2Wz1aUTCXSRzG2T3zPJjj7R2qr38RHlbDNcn8eQqxDP6D2Y6SyA77mbOzHh6nQilObFu3ecF3sqmySKri9jLF0aTojJt19yKf4jbjZhBZp/FIGdca45AKJi0isXNTE03Y4Vex0b3oeLSBojna45dJtRuVogwXMjDa5dEI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(26005)(76116006)(186003)(110136005)(316002)(52536014)(66446008)(64756008)(71200400001)(5660300002)(66476007)(9686003)(55016002)(66946007)(66556008)(2906002)(6506007)(8936002)(83380400001)(8676002)(7696005)(478600001)(53546011)(86362001)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jtZwXLfMnElU5UipK96TjolPdHXv7aGez9G0Sb24khh9j2LhYSkfzB88z0PdSkD5L76wy95BHAlkPoqDhF9dc4v51XrJ6hv1PH6IWgpb9gvr88VOQAt1ewCVWfYVhikQ7ZOKCbK3GGqHHMX+d/RnKUY3krlTzO4nO3CUUfAmuJMK7Bas22cbPisIUAcbDvwrbqA1tnw12D2evknDbV0x3S5G0DVuy/VK+WoQY95nqVDkKulu8bxv8wCoAp6egMSLbku5Txw2zaIMkwkP9IyLXdcxjisc9b0rKbuKt6sHNsr1B5QG9N0eq/sbN7GGi3/fF5JItEG18tislEb+obUpLZjd/cFM/kZ66nIfShhTut5joX44tKoDeChHN9wUi4ufVTqwTcsmZi4D5WbfW3tnF/1+iBtuE/VNHQKwmf46u6YVJxRM3zuT4CMm6eiem38uXDhr85qqCgbcu6hOiHTWUlHR2zlLCk6jansvN4efz+4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b3479-c0be-41a7-4600-08d81483d951
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 19:06:19.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv8ohcIGu5S/gr8F57gsFf5pqFutlJH28gZmenevO/eHQZxNgZmVfqTHycOfSJBSgEShFyLO1QQ2MqKNL2GRvpM3b32JdX05uLzFMCDZpnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6021
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/20 8:50 AM, Matthew Wilcox wrote:=0A=
> This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.=0A=
> The advantage of this patch is that we can avoid taking any filesystem=0A=
> lock, as long as the pages being accessed are in the cache (and we don't=
=0A=
> need to readahead any pages into the cache).  We also avoid an indirect=
=0A=
> function call in these cases.=0A=
> =0A=
> I'm sure reusing the name call_read_iter() is the wrong way to go about=
=0A=
> this, but renaming all the callers would make this a larger patch.=0A=
> I'm happy to do it if something like this stands a chance of being=0A=
> accepted.=0A=
> =0A=
> Compared to Andreas' patch, I removed the -ECANCELED return value.=0A=
> We can happily return 0 from generic_file_buffered_read() and it's less=
=0A=
> code to handle that.  I bypass the attempt to read from the page cache=0A=
> for O_DIRECT reads, and for inodes which have no cached pages.  Hopefully=
=0A=
> this will avoid calling generic_file_buffered_read() for drivers which=0A=
> implement read_iter() (although I haven't audited them all to check that=
=0A=
> =0A=
> This could go horribly wrong if filesystems rely on doing work in their=
=0A=
> ->read_iter implementation (eg checking i_size after acquiring their=0A=
> lock) instead of keeping the page cache uptodate.  On the other hand,=0A=
> the ->map_pages() method is already called without locks, so filesystems=
=0A=
> should already be prepared for this.=0A=
> =0A=
> Arguably we could do something similar for writes.  I'm a little more=0A=
> scared of that patch since filesystems are more likely to want to do=0A=
> things to keep their fies in sync for writes.=0A=
=0A=
I did a testing with NVMeOF target file backend with buffered I/O=0A=
enabled with your patch and setting the IOCB_CACHED for each I/O ored =0A=
'|' with IOCB_NOWAIT calling call_read_iter_cached() [1].=0A=
=0A=
The name was changed from call_read_iter() -> call_read_iter_cached() [2]).=
=0A=
=0A=
For the file system I've used XFS and device was null_blk with memory=0A=
backed so entire file was cached into the DRAM.=0A=
=0A=
Following are the performance numbers :-=0A=
=0A=
IOPS/Bandwidth :-=0A=
=0A=
default-page-cache:      read:  IOPS=3D1389k,  BW=3D5424MiB/s  (5688MB/s)=
=0A=
default-page-cache:      read:  IOPS=3D1381k,  BW=3D5395MiB/s  (5657MB/s)=
=0A=
default-page-cache:      read:  IOPS=3D1391k,  BW=3D5432MiB/s  (5696MB/s)=
=0A=
iocb-cached-page-cache:  read:  IOPS=3D1403k,  BW=3D5481MiB/s  (5747MB/s)=
=0A=
iocb-cached-page-cache:  read:  IOPS=3D1393k,  BW=3D5439MiB/s  (5704MB/s)=
=0A=
iocb-cached-page-cache:  read:  IOPS=3D1399k,  BW=3D5465MiB/s  (5731MB/s)=
=0A=
=0A=
Submission lat :-=0A=
=0A=
default-page-cache:      slat  (usec):  min=3D2,  max=3D1076,  avg=3D  3.71=
,=0A=
default-page-cache:      slat  (usec):  min=3D2,  max=3D489,   avg=3D  3.72=
,=0A=
default-page-cache:      slat  (usec):  min=3D2,  max=3D1078,  avg=3D  3.70=
,=0A=
iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D1731,  avg=3D  3.70=
,=0A=
iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D2115,  avg=3D  3.69=
,=0A=
iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D3055,  avg=3D  3.70=
,=0A=
=0A=
CPU :-=0A=
=0A=
default-page-cache:      cpu  :  usr=3D10.36%,  sys=3D49.29%,  ctx=3D520772=
2,=0A=
default-page-cache:      cpu  :  usr=3D10.49%,  sys=3D49.15%,  ctx=3D517971=
4,=0A=
default-page-cache:      cpu  :  usr=3D10.56%,  sys=3D49.22%,  ctx=3D521547=
4,=0A=
iocb-cached-page-cache:  cpu  :  usr=3D10.26%,  sys=3D49.53%,  ctx=3D526221=
4,=0A=
iocb-cached-page-cache:  cpu  :  usr=3D10.43%,  sys=3D49.35%,  ctx=3D522243=
3,=0A=
iocb-cached-page-cache:  cpu  :  usr=3D10.47%,  sys=3D49.59%,  ctx=3D524734=
4,=0A=
=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
[1]=0A=
=0A=
diff --git a/drivers/nvme/target/io-cmd-file.c =0A=
b/drivers/nvme/target/io-cmd-file.c=0A=
index 0abbefd9925e..02fa272399b6 100644=0A=
--- a/drivers/nvme/target/io-cmd-file.c=0A=
+++ b/drivers/nvme/target/io-cmd-file.c=0A=
@@ -120,6 +120,9 @@ static ssize_t nvmet_file_submit_bvec(struct =0A=
nvmet_req *req, loff_t pos,=0A=
         iocb->ki_filp =3D req->ns->file;=0A=
         iocb->ki_flags =3D ki_flags | iocb_flags(req->ns->file);=0A=
=0A=
+       if (rw =3D=3D READ)=0A=
+               return call_read_iter_cached(req->ns->file, iocb, &iter);=
=0A=
+=0A=
         return call_iter(iocb, &iter);=0A=
  }=0A=
=0A=
@@ -264,7 +267,8 @@ static void nvmet_file_execute_rw(struct nvmet_req *req=
)=0A=
=0A=
         if (req->ns->buffered_io) {=0A=
                 if (likely(!req->f.mpool_alloc) &&=0A=
-                               nvmet_file_execute_io(req, IOCB_NOWAIT))=0A=
+                               nvmet_file_execute_io(req,=0A=
+                                       IOCB_NOWAIT |IOCB_CACHED))=0A=
                         return;=0A=
                 nvmet_file_submit_buffered_io(req);=0A=
=0A=
=0A=
[2]=0A=
diff --git a/fs/read_write.c b/fs/read_write.c=0A=
index bbfa9b12b15e..d4bf2581ff0b 100644=0A=
--- a/fs/read_write.c=0A=
+++ b/fs/read_write.c=0A=
@@ -401,6 +401,41 @@ int rw_verify_area(int read_write, struct file =0A=
*file, const loff_t *ppos, size_t=0A=
                                 read_write =3D=3D READ ? MAY_READ : MAY_WR=
ITE);=0A=
  }=0A=
=0A=
+ssize_t call_read_iter_cached(struct file *file, struct kiocb *iocb,=0A=
+                                    struct iov_iter *iter)=0A=
+{=0A=
+       ssize_t written, ret =3D 0;=0A=
+=0A=
+       if (iocb->ki_flags & IOCB_DIRECT)=0A=
+               goto uncached;=0A=
+       if (!file->f_mapping->nrpages)=0A=
+               goto uncached;=0A=
+=0A=
+       iocb->ki_flags |=3D IOCB_CACHED;=0A=
+       ret =3D generic_file_buffered_read(iocb, iter, 0);=0A=
+       iocb->ki_flags &=3D ~IOCB_CACHED;=0A=
+=0A=
+       if (likely(!iov_iter_count(iter)))=0A=
+               return ret;=0A=
+=0A=
+       if (ret =3D=3D -EAGAIN) {=0A=
+               if (iocb->ki_flags & IOCB_NOWAIT)=0A=
+                       return ret;=0A=
+               ret =3D 0;=0A=
+       } else if (ret < 0) {=0A=
+               return ret;=0A=
+       }=0A=
+=0A=
+uncached:=0A=
+       written =3D ret;=0A=
+=0A=
+       ret =3D file->f_op->read_iter(iocb, iter);=0A=
+       if (ret > 0)=0A=
+               written +=3D ret;=0A=
+=0A=
+       return written ? written : ret;=0A=
+}=0A=
+=0A=
  static ssize_t new_sync_read(struct file *filp, char __user *buf, =0A=
size_t len, loff_t *ppos)=0A=
  {=0A=
         struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };=0A=
diff --git a/include/linux/fs.h b/include/linux/fs.h=0A=
index 6c4ab4dc1cd7..3fc8b00cd140 100644=0A=
--- a/include/linux/fs.h=0A=
+++ b/include/linux/fs.h=0A=
@@ -315,6 +315,7 @@ enum rw_hint {=0A=
  #define IOCB_SYNC              (1 << 5)=0A=
  #define IOCB_WRITE             (1 << 6) =0A=
=0A=
  #define IOCB_NOWAIT            (1 << 7)=0A=
+#define IOCB_CACHED            (1 << 8)=0A=
=0A=
  struct kiocb {=0A=
         struct file             *ki_filp;=0A=
@@ -1901,6 +1902,8 @@ static inline ssize_t call_read_iter(struct file =0A=
*file, struct kiocb *kio,=0A=
         return file->f_op->read_iter(kio, iter);=0A=
  }=0A=
=0A=
+ssize_t call_read_iter_cached(struct file *, struct kiocb *, struct =0A=
iov_iter *);=0A=
+=0A=
  static inline ssize_t call_write_iter(struct file *file, struct kiocb =0A=
*kio,=0A=
                                       struct iov_iter *iter)=0A=
  {=0A=
diff --git a/mm/filemap.c b/mm/filemap.c=0A=
index f0ae9a6308cb..4ee97941a1f2 100644=0A=
--- a/mm/filemap.c=0A=
+++ b/mm/filemap.c=0A=
@@ -2028,7 +2028,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb=
,=0A=
=0A=
                 page =3D find_get_page(mapping, index);=0A=
                 if (!page) {=0A=
-                       if (iocb->ki_flags & IOCB_NOWAIT)=0A=
+                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED))=
=0A=
                                 goto would_block;=0A=
                         page_cache_sync_readahead(mapping,=0A=
                                         ra, filp,=0A=
@@ -2038,12 +2038,16 @@ ssize_t generic_file_buffered_read(struct kiocb =0A=
*iocb,=0A=
                                 goto no_cached_page;=0A=
                 }=0A=
                 if (PageReadahead(page)) {=0A=
+                       if (iocb->ki_flags & IOCB_CACHED) {=0A=
+                               put_page(page);=0A=
+                               goto out;=0A=
+                       }=0A=
                         page_cache_async_readahead(mapping,=0A=
                                         ra, filp, page,=0A=
                                         index, last_index - index);=0A=
                 }=0A=
                 if (!PageUptodate(page)) {=0A=
-                       if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
+                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED)) {=
=0A=
                                 put_page(page);=0A=
                                 goto would_block;=0A=
                         }=0A=
-- =0A=
2.26.0=0A=
=0A=
