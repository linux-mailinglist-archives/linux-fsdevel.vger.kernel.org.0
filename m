Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5711A45A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 07:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfLKGQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 01:16:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14901 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLKGQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576044995; x=1607580995;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wKrKs4Fth6/z7XFVwrltfSTgFcadUHn/ome+7YOJHIc=;
  b=BOnJpTYyYZjUFUd5oFSkmE/2htVbayySEIdrzb1bGuB3BQJk+dlxqJU0
   5P2/bADSTZ9/0Oz4dKp/cFLqo34dbemlJxWETaYD8+jkAh5COXbxobC0x
   rm4g60Rh1eyekjXiOcM0kzQSl9wR0vaFKRCYABc6ZOoSW9pgO4hOItWLC
   UdUM9EmYl3+Fzig9Rtw+1iG/Vnm7TDaz00iDmX/i/PWjPR3PCHBBhParB
   rYuHzNPRfI+P7/LoBhak3xnn/2npTxwCxhOw+2GLlg2sMxG1B+lLD13Bm
   wji8iU8vHQCZ3+eN+1ea2l56D1qCTRUVe+pxx2lj4QeTeO599QKjP2W05
   w==;
IronPort-SDR: TRk11DTviKUKVUeYCXqNc6aCA0MqYZpXyPv6AZpK4I5MVyxnVQtTfkDHcpiHfwpw8uI7ZnpIru
 zHExT22uBdfR/c5uiJkkdXxDjW8eHqEWO1IeGrigeYgBNORDKAi+gEaSNqjW9EX7ESzNi2J2CG
 Pahtc2zTe2PslwOwk0PCEVOSkKpSAWmUfqAt+LeiS8PAylOIZtxGDezw53cRhp7fd0rHdrkLoS
 9LP4f8tbS+FB7vtIeTMk6t2P7ffQ+3BHYvsmFcNXjJQ4NMtrAhw6sggEdODdnFexC0E5HAkivq
 H34=
X-IronPort-AV: E=Sophos;i="5.69,301,1571673600"; 
   d="scan'208";a="232612405"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2019 14:16:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH076ko/hl+QLTg85syzEVpe6oxJmZqyVgxcVGQ//ncz6X1dEqHloWt7n45OhQs03Q3FEgy1Pe8LUhGlXcO8bq9cU7PzS1k8jBdB2pYLQl9/yy0eXLqKMf8AB2tWwt29dQxWAmH+JrOuSpQ+viN/JCrGO4olBawmB/q55LOLEuLsm/oBQn/b60XIAIkyZmdu3JRIPu9Ri8TXq961isq6oVUlchC7WFmVESWz2fJwB1FYZ29XgCtd0ShwgFJFAx6p3Xsjs1qr4gqvL+E9F6YIQ6V1osacZWRqL7dvj4pCoiQje6pEPGJIAbG62R24YFQtQSYizU9tCptcTsy2BRYpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oAeDD/L0QXcCKoeafAvIYqBW/ibXXcwGxdJT2kQA98=;
 b=MC1WUYCxJB2hjAEmkE08/qmjBqM0nQ389gvWGFcL1bNvw8MWifnPaJnvvP1cHlRE2+t6bMZl+LuHNWgMIl1m+BCUUT5F7q6ujKYAL6Uh7Zlzu+5LN6dnh426ki3fyFO7XIdVA9ID4eHrWFQsKw+pXdgMiNhKa1ZN7x4Vl6C+22z0WD7uTzylXqeRLcE8GgQ2JK+1bLp5rmDUZFj1ntGOSkn5kgWe8VATpEY/FIFM3cpfxmtdmC/5yO01DTjRo9ZRyI7mGdR39iGQghPF9LtiMdc1UprtGamoe3tc6DZ+lUmTK8cIvuwY4+Aw01H3xj85lqjL/rOVF9pbGRnZ1oZ4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oAeDD/L0QXcCKoeafAvIYqBW/ibXXcwGxdJT2kQA98=;
 b=dB6BCVZEXvycpOlR3LQ6hsqVwa04jwKFKmWdFVQjyXxMSL/86cIT4I/MTe0eST8i9zevZF9uMCDJ0nOpdacU84W7EP6woa963v5CbpFuJUwg5FjOsTIJDJaoNhHFCpsH6ImmFJymC4uCF2ehY2swn5d+cmo3KsSTkt+ZsXxRWhU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6232.namprd04.prod.outlook.com (20.178.232.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 06:16:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 06:16:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Subject: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date:   Wed, 11 Dec 2019 06:16:29 +0000
Message-ID: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b4ea572-9091-42b9-709e-08d77e01a944
x-ms-traffictypediagnostic: BYAPR04MB6232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6232E5FDAC18FAED4AA2FE58865A0@BYAPR04MB6232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(78114003)(71200400001)(186003)(26005)(52536014)(5660300002)(7696005)(6506007)(4326008)(966005)(86362001)(316002)(478600001)(2906002)(54906003)(81166006)(9686003)(8936002)(8676002)(81156014)(7416002)(6916009)(66946007)(64756008)(66446008)(66476007)(33656002)(76116006)(55016002)(66556008)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6232;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jitJ1K7ITxNBu9+GmPVPzwWBsyV9o8I1dykswJhMK7/YOziHaJL5RDIX8hZx9ZDKAPtwvPOUWJXET4KcWIl+n9Vzajj9yYqEe6jr5FyyiVFyirP+D5vtq2jaGFmNiz/B1NoQpl1XBwI0K8hruTDrIwtbTd8k6BHyz0QjHkJYT3Mz5EkftVfBj9Yvw+1y5sC+3UbIF1kZ5P54BNSqxDiQViEL6iOzL0BwRRalt8b8k3Vx7M8itLCPdlZA1wIUn6OoTmVdjszBYDuxLUv/Tlbd8YDDrtXPQh81eJnZIiM9M6hue9dnljE/QL2aYNrLCuZ7NP1LHe1ss7qC48nz+s82ZzSpvCnvDgMtBOTtTI1mMNoiAC2kRiTyIv6VY0hIu6lDcTSbuDx5fdq8EoD4HfwOAS5OyfB0yhFkY/KrwTdMfymtxdxxdFD5e9OYpDKIKbKzLZFE6bH3pahWlOJuIXvWdqOWtC4ioHKA2j8miimVpIDCYF8RLlVh6PcmmwFRTP09VJw9MadIbVPeq6oU2wVFGEcNeNMxqS7GhZ8L1Nr3+gFfJt8cLtviwYxMo0DYDfYG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ea572-9091-42b9-709e-08d77e01a944
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 06:16:29.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Mtgm4EzbLIE2WEMlfCWpKPYXQLWrPYboSw3VXb/hBNtdz8NGvcuoSlGXoD21MslNdCfrk/Y1NUtNaQvzSJ5OMx1dq1mL+VI7JWGTkJ/xjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6232
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,=0A=
=0A=
* Background:-=0A=
-----------------------------------------------------------------------=0A=
=0A=
Linux Kernel Block layer now supports new Zone Management operations=0A=
(REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).=0A=
=0A=
These operations are added mainly to support NVMe Zoned Namespces=0A=
(ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,=0A=
user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,=0A=
Device-mapper in order to support these devices in the field.=0A=
=0A=
Over the years Linux kernel block layer tracing infrastructure=0A=
has proven to be not only extremely useful but essential for:-=0A=
=0A=
1. Debugging the problems in the development of kernel block drivers.=0A=
2. Solving the issues at the customer sites.=0A=
3. Speeding up the development for the file system developers.=0A=
4. Finding the device-related issues on the fly without modifying=0A=
    the kernel.=0A=
5. Building white box test-cases around the complex areas in the=0A=
    linux-block layer.=0A=
=0A=
* Problem with block layer tracing infrastructure:-=0A=
-----------------------------------------------------------------------=0A=
=0A=
If blktrace is such a great tool why we need this session for ?=0A=
=0A=
Existing blktrace infrastructure lacks the number of free bits that are=0A=
available to track the new trace category. With the addition of new=0A=
REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can=0A=
track more number of requests.=0A=
=0A=
* Current state of the work:-=0A=
-----------------------------------------------------------------------=0A=
=0A=
RFC implementations [3] has been posted with the addition of new IOCTLs=0A=
which is far from the production so that it can provide a basis to get=0A=
the discussion started.=0A=
=0A=
This RFC implementation provides:-=0A=
1. Extended bits to track new trace categories.=0A=
2. Support for tracing per trace priorities.=0A=
3. Support for priority mask.=0A=
4. New IOCTLs so that user-space tools can setup the extensions.=0A=
5. Ability to track the integrity fields.=0A=
6. blktrace and blkparse implementation which supports the above=0A=
    mentioned features.=0A=
=0A=
Bart and Martin has suggested changes which I've incorporated in the RFC =
=0A=
revisions.=0A=
=0A=
* What we will discuss in the proposed session ?=0A=
-----------------------------------------------------------------------=0A=
=0A=
I'd like to propose a session for Storage track to go over the following=0A=
discussion points:-=0A=
=0A=
1. What is the right approach to move this work forward?=0A=
2. What are the other information bits we need to add which will help=0A=
    kernel community to speed up the development and improve tracing?=0A=
3. What are the other tracepoints we need to add in the block layer=0A=
    to improve the tracing?=0A=
4. What are device driver callbacks tracing we can add in the block=0A=
    layer?=0A=
5. Since polling is becoming popular what are the new tracepoints=0A=
    we need to improve debugging ?=0A=
 =0A=
=0A=
* Required Participants:-=0A=
-----------------------------------------------------------------------=0A=
=0A=
I'd like to invite block layer, device drivers and file system=0A=
developers to:-=0A=
=0A=
1. Share their opinion on the topic.=0A=
2. Share their experience and any other issues with blktrace=0A=
    infrastructure.=0A=
3. Uncover additional details that are missing from this proposal.=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
References :-=0A=
=0A=
[1] https://www.spinics.net/lists/linux-block/msg46043.html=0A=
[2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-=0A=
namespaces-zns-as-go-to-industry-technology/=0A=
[3] https://www.spinics.net/lists/linux-btrace/msg01106.html=0A=
     https://www.spinics.net/lists/linux-btrace/msg01002.html=0A=
     https://www.spinics.net/lists/linux-btrace/msg01042.html=0A=
     https://www.spinics.net/lists/linux-btrace/msg00880.html=0A=
