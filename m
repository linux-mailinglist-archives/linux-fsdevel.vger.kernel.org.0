Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481C932C509
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381707AbhCDATD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38767 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842507AbhCCIGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614758759; x=1646294759;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AxLLliw2S3xgZMbz5gs2fIoDcaYlmQC85RD+KlGdA0E=;
  b=quAwZYx1nyXvCNwDrQMWvDf62wRLsOTZVtkjf6fHz54MRHcASEJeycEi
   jLYii7cj+BOtUZ/DozVZaUfi8u++6qbrGVKcnR4rDPA8DpdP4afOvAydZ
   KLiRDpgvQ57UpAO6w97dqInK3Ly+B6p0Tm5DSz1QSB0zI3q4fbjQ2b3jf
   A1fKZAOZ1FkYwFSIekeSZurNseqetkr+4/yuAoGVaDvUCTCHkS/JvIQAL
   MYNVdSkhJokytPj2WhdxcXYu4EFQaUquA88FMppXtUcrbdx9QLOhIgxFk
   GmCotn1YnlhILnCUYvH0ZxwkDeJcKNkZ0rpL5+AK3tZiE/cRxIwlZfPJi
   Q==;
IronPort-SDR: 6cjAkxbJjtgPW4INckPTYVRkA09/LKW7jqM/UWKkMakGH+kkST5rw9Yc/VyXigts+dgnQ/8s+m
 OOMb/i03p5lWRwmSpHUuW9oHUuhOY1NP9sxO9EUdyB2g2KuU7wmhSXlYAZEGxkcaSiFkKOp8Mv
 qeYfHfN5D0hFnJPLBxWawMaiWiMW6biwddzMMlB+0II4YGhW09WThOIeRMvr22V9ogYq7Kf9j7
 8e/rKagA/zzCk57X6altHFn2xQtlnhDdMt9CauXCdXMw6023/g3F2HOV9DePesm43m1XHMwdzp
 fz0=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271853936"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:04:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPPAXXjw697zU1DNR5770BPZElHfvVLTLt5q0ogzmvRnqi6rysVzwxUQVOY6wfTltFKvznTB94lzPjTbXPDJH/6o7O5pHGKbrqhTx3t5soxHymccOnfq66xHbu1EsC2bFEQH8MpgjLovEmZClJXWWISn80s+u/9KTHuxqrwM8ZkeWRmzTp5zvQ9i6EVR0+zrNvdWcmYyW3yUa0rykflrTMBxIyjVE5/W4ro0rE6a+EOOG0psWuEDwJuh+LLdtxqBCkvK+Dm0H7HIV8BbvI65s0m2g3opZUXXB8jF2Nlb7ViXIAsUarVYXeLqjdPE8IN897RV5gUk6QV63GnZdGTqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxLLliw2S3xgZMbz5gs2fIoDcaYlmQC85RD+KlGdA0E=;
 b=Amu3tWAY8CYc+GUbwCWWrif9Qf18/6zhm2Dj/eWv6bC0jWzTMecl5HdlXw7cDvHTpUbA96K84oicBPe58KZjXFSle9WL+4MWoxbq/Ot3MQkfJzs/F/oZ0oetD8qH7K6pF4267t/vPAEae8lKrl6DWU63WbtMnELbzUZKTqtA38GZojAJj7GZ71ty6YxWp6NQ3NiTrMT+bakluNqzcL4mY8ysJb+nKU71gEGKcJHmM7VO8j/WrEugTvPEpOTX59ZlcloHILTvFICRLrEmWlo9y1pWb0TXVAxH2f6RwnTeRbxf4PFt3oPGB3NdQp2icTEwFeOKiUxLuX6FavZg5JlUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxLLliw2S3xgZMbz5gs2fIoDcaYlmQC85RD+KlGdA0E=;
 b=ihv+EIPIhFG/LSruLwvY2VmX2hfsKpbgLlauKbLDOnovBdmRm3rX7TF1TQK27k6BMy9YwEIwp1e8jlmveNqlNghfE86ZD3GAwjCcUzsEHefRyv+4HurXZLzJs987Q9FNMKq+0J1cydqQo9XfG4ALcSrynMzLqB4EXK67d05i/bk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7464.namprd04.prod.outlook.com (2603:10b6:510:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 08:04:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 08:04:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] fstests: add missing checks of fallocate feature
Thread-Topic: [PATCH 1/2] fstests: add missing checks of fallocate feature
Thread-Index: AQHXD/IpV70yJCqK3kCkX9xJWKpfmQ==
Date:   Wed, 3 Mar 2021 08:04:53 +0000
Message-ID: <PH0PR04MB7416904201518476C2FF13609B989@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
 <20210302091305.27828-2-johannes.thumshirn@wdc.com>
 <20210303060152.r2xi46ke6bpfifyk@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ccec:1858:7740:59e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a70afcf-f60f-4ca1-3ed1-08d8de1b06e6
x-ms-traffictypediagnostic: PH0PR04MB7464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7464D4C5F4BB922E4B0D207E9B989@PH0PR04MB7464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zh/FPjsJJPVd/TAYjm7X+Au9qNldqkn1BgL37Gsw/0MA4pG1/SnsL4aAhuvwD//XcraoZKkb+oASL9xiUz54m7U8VejALmdtgz9BefRgzwEp/silLOn4Cqp26PbwY1/AskrWWOTETSTj0o9nVqYjvaoC6kPBNiOpMWx1OEv7nQg5LJjz3n2j68NCCFw+H9wmRxX9/ReYkl1sx4WqVrL92p12HETneFkaBzSJAddj5DPZ7sjZUZYb0P6/SwQoveBq51i2jDcZAlN3UdPSMtXfYrVaTMc9UJkQmLaboTgUgsIKDhGmxwJdqBPZ1EQc6bGPZjiDdrL7RqLCZGiXHZU94Z0g5Lf+Vmi/3+2fp54V+GBFaR2hbS5MQAZSRuNjuy7GwhF8JpxcStgULELlC8lVxTORofR8DtyQhLqjuPoyYWYLCSDg2J8nG1toEuSxbtBUCutjhLn0TaKKJhzDXz3CmGPbi/XG63WefC2M9VJHQoVtBOOUln28JAks2ihAj642rqRET6mgJ/n5GJnY9nwpcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(316002)(86362001)(478600001)(186003)(76116006)(9686003)(55016002)(91956017)(54906003)(4744005)(53546011)(71200400001)(8676002)(8936002)(6636002)(33656002)(4326008)(66946007)(2906002)(66556008)(6862004)(52536014)(7696005)(450100002)(66446008)(66476007)(6506007)(64756008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ikxLxbzxyTsUC6G76rwc/F1zkrGELV6VgHYueR4eVddz6NKWNE+wKyoOiGRb?=
 =?us-ascii?Q?dvNSk+XREQ9BCQLGr9oGI0F1mbqu4EOXFH8J9J/lcNOu3VZ2Ir8cfAHsZIda?=
 =?us-ascii?Q?VeAJeTITDhDnIJ2M2sG2oGj3xZawhgd30rZFww8nnD1KXUH8GtKcmV+MKiPs?=
 =?us-ascii?Q?v7pW3n2f0Ewwm4vR4EM4A0Rz1usfCySJOsXZUu+D5vzFvwhfb3pNdLNupBAn?=
 =?us-ascii?Q?8ba4xvaexaVb7RqnMKvCrKt/6iXVApVQvbvvQhYEwqkYaiZhN//B1nZVgAYh?=
 =?us-ascii?Q?Dfqrb9J5zN9eV6DHVGFqFglJs9ZNCWwz9A+vSFJMYLlQyrc7xxqtucUiVHhi?=
 =?us-ascii?Q?T5KFu0qLAdspNol5Vzm2txY+MBkBSjWcP98nSeyiSYQjfEW32vtSe7+4dGom?=
 =?us-ascii?Q?XqhPrHQV7aYbENOABuX9946O94qZ9CMOZ8NniHOOoHtce8cCxNI47b3PyHid?=
 =?us-ascii?Q?/2wd0nkT0ZS4Ab8LkzietaePSaSMztIjfnPXz9xhMa53CwDSYmhV+VXJLG3I?=
 =?us-ascii?Q?d6Y2R7u7eLJfUfSyFx2iSSnjNM/4JnDRtb1hr+x9I7bpxGw1L7NbCeVLfHkQ?=
 =?us-ascii?Q?EGMZcHZIxcLichJ+spXsbVCMunIV9bxN+aectrYcpxAwpjL5mwgCsd0ufAu1?=
 =?us-ascii?Q?kwSBdZxjNERUOHxzShhjX1gBSzB5GcJRIX1L1Vs9Ny7xqBi5l/Ww2V3FZeo9?=
 =?us-ascii?Q?dciUWvjXcoQjiBW6XAQYCynk2X6/Z4N3VCpRe+0Rt5AHG0d7GfbKPvgoMUWd?=
 =?us-ascii?Q?BYY8mhdgW6Tqv/QP21/ak6YpzRRBwC9jqJVbYekYYGcQ1RFgkyic6HOZOn+x?=
 =?us-ascii?Q?2HBBA+LEtXKGw9b2qyp2RUcMpulVv2lh5iQDfijHmhEDQrXNVjCA9JMQDsrp?=
 =?us-ascii?Q?mDHLn6xHl5La8yqwSlec6FdYZ+Bf27AcJYlKuyr9+6zpiIUZsAuyVLji/7RB?=
 =?us-ascii?Q?jxrXBWJwasPeB67xjhYQkJpeRWHSIbxocjWaZeoO6Z/Fs7vQUi2/GSLwP88s?=
 =?us-ascii?Q?2xKYjn1ajg6KuheWVrZvO3810Ln0dD2lD5In4ug6WkEvirER1JF58heYUuOZ?=
 =?us-ascii?Q?eene6EprQXc6dhO8UBIIb+OFXdio5cek9ORZS7/UNxv3JjwfhWMv85be3/Od?=
 =?us-ascii?Q?v/DTuugKnGzPrwv47CIoswbeUBUQ06JCSDEXI10lGasRCXGAm0IflDqe22PU?=
 =?us-ascii?Q?/w60w//DAbm8P+CEprzVLH2C7dkYt1XegUg5jMT6RycievIPlqsK5ZZH8Wjk?=
 =?us-ascii?Q?Mj4jYhZFjrzJ5vOvtqllkjCVyY4YbgPB32QpotiyUuQ3z1FxmAHWXRBFx9GZ?=
 =?us-ascii?Q?9F1Zf8kZ239B6T51JE3wt+8ns6YXjFzol1ik3e5F/DLe5hPx5GnYC4RnPteB?=
 =?us-ascii?Q?GXXc6zURYmeWrse5V4VQj6IoykM0tpQDHH1PJh7cqV3X4CGYQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a70afcf-f60f-4ca1-3ed1-08d8de1b06e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 08:04:53.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6O7p5G8Z88ZRmSA5aAvtZifEzqhDGy3qpibQdgKu+0KqSrk9JlL9GNkAj9U0hebFnJrSl2K9idN+emnWFAE7tJb4c8jVHr5PBojs0HHIks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7464
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/03/2021 07:02, Naohiro Aota wrote:=0A=
> On Tue, Mar 02, 2021 at 06:13:04PM +0900, Johannes Thumshirn wrote:=0A=
>> From: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>=0A=
>> Many test cases use xfs_io -c 'falloc' but forgot to add=0A=
>> _require_xfs_io_command "falloc". This will fail the test case if we run=
=0A=
>> the test case on a file system without fallcoate support e.g. F2FS ZZ=0A=
>>=0A=
> =0A=
> The sentences between "This will " .. "e.g. F2FS ZZ" should be removed.=
=0A=
> # Vim command leaked to the log ... oops.=0A=
> =0A=
=0A=
Ok will fix that up=0A=
