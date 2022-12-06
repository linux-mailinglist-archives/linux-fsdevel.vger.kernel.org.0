Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6C644260
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiLFLrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiLFLqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:46:50 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90A18B1F;
        Tue,  6 Dec 2022 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670327209; x=1701863209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rJ41pwF4/yhOocWgQUnnoOvuYLy2WnJgWVDYL8TN6twV7wt5sN8dmmjO
   8StO9sizrAFO7rvxOopWj6eJzURWLhlNg9T1qRTFij7JswvsPWq9ZRkB+
   IasPzktNdCH+TRTzynINPI+hTEpMawBH2bkz5tpuu7RmbnzEZ5EgBozkl
   Vg/F96PQI+5arzklFAtGMOrXD83QTp/jloQYhGMnGR8szxadLvaExLWL7
   sEDS3uaEnpkRK4/2kfCdgPvoTCnQ4gvEuRHHW8K9y5O+dThPOFeyBq0Oi
   xRcVDjjGxkmYPJ7rOESxIbk2oMevKG895UXxxqtuffUsgssrKdNe8RqVc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="217999205"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:46:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6s55drCrAvf0mo4/XWssBqke5rHFK0JGti6JrHkmJ2NOu7y5VeWxu8kDp5SHuF8R9TretSoX94+WT+cIdrxt/J1wCYI+rQdA6dW8qh0hpIGC5iTVoLixfyKoVRHk9vLWmmtDlMm4Lzdb2oZNawSiAwEtl6EsXJ8iE6NGXKnsDwJzE8eyzXFZZ4w2A1TTKuCv1jMqYoHNqF2zNqafacZMbWN8s8fDMvhGA7LgqTjz+CXSdm1RSHM96pVQj6F1jXNd7mNafPsxrXdWgBT5y1HLt5IJuhmyKI3ds6zbaL5jHblgcXfATwHQg7fw7nlD8rZP+Vlg80q4jvL/X0/iM4SSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=muJejcgbcox3sVQMGPXvs3Jblrv3MN7Cy0cBo6z07WEUNku7RyErIO4qKgMIep0jCz3VFaI/PkL4f6oG7w+ITIEy+4GBvVl5jQgmmr/6o72Dx/BHdsLQ4gZ6z2oGokgphK3qBExBHgXUDv9pA8nZxZJiQKKaIxO/r++uUrh0tyjB256x45gf/8KRM/P70xGVbpyVQuZnR4ddAqWPnsjWvDjkJk1IZQIgwR3jrr56m+69Kyab9AMnqqCn+jOW+sfNLOTcu8KiqXok8BSAKKs4PwBkKGRpSe1IQ7mR0ZhLYaWGjpj2psbVifqIME5VvXq8UdiWOdlPj4MYNpbwYGh3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wsAGeQ5rksxVC1krawyuXcXqHT6rYVqKYFB+j6EBM/05AeudYJIQplfPbM7/XsD6Jnh6H6If5kYLN37u9sMnya/XUTeG3BU8MJqvaFVLysiFwMrnbPf/STAvhO9JQuw1vIyal3tvm+guOjeOPnKomf3tc2AIrGEc2tIpAtV8EVk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8231.namprd04.prod.outlook.com (2603:10b6:a03:3fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:46:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:46:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 17/19] btrfs: calculate file system wide queue limit for
 zoned mode
Thread-Topic: [PATCH 17/19] btrfs: calculate file system wide queue limit for
 zoned mode
Thread-Index: AQHY/N5lFHE+YwxMEEC9igmsNY9kz65g1xYA
Date:   Tue, 6 Dec 2022 11:46:44 +0000
Message-ID: <f24b09e8-9f4d-bf48-f40e-4e46ab4bd439@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-18-hch@lst.de>
In-Reply-To: <20221120124734.18634-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8231:EE_
x-ms-office365-filtering-correlation-id: 8271505e-ba5a-45b3-fa3e-08dad77f8ca4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bvW1L3S6pm9S/+VCyZ5WqtOXbUPU8WmnSC6j6PqcECyKkcofkwgrKzvUVhN5hMiGiDCiOYtXSQBd5LR37tlXb55dL4fCzwCyl1bgIr+a2GPkf/IxqtBl7GEWn/Quiwrx8H7XSIn43AYF8t+ufQ4OnmX6mx3tmNa2MMKTZvHEEThinf2gItrpIbcqMMdeGl61z4DLLG4sXEojZyAJWpfh0AaaZGxI7XEyWtfPgH9FydgtPABwss7MljYOTCKdJix8I2eSwFBQc0UKzKv+lCimgTgsRRpek1mzSbKbUU9PbroANmjbwyly0LVPDw9Mmdl9F79G6f/AHH7FOJ5lahCQHIvUZyVSVa8lSiWp+p47++uOsnh74USdvZzdvdGTXKsMSJJeVlh3HUO46eInR/CTtrxVQoScro5f6g284ABl2Wu4at9jk9QJ3pUM1+tQuF8Vv7G+MsTd9lpbyQdf6EM9y2ET/qCc6fhcZraevdgMTU5ERh1Vg3lZlLZ6vF1PMCqBy34kSRRS3dvLnhD4Gc1azmEFaDP2OaVaC2iWU3kplt1XOjpIzCq8jTa77+lgcd4cf/DGBSX/J8X+BIMtFYRfQI5VXkUi6fF03gHhgsYzznqoWwU+gSYlyL64iDcdsLEOaNC0gDJVLEHAOOiFTm7ZERjtUncEGs9u9I7yOtZmSvxkbLeTBPZwwqCgT2O08t7zvTHmdP6lqu863iXrstW2+87WNens19EA4Up9FHaDtSMc9VAkZ7g8t/wyUMK8dCzul00B3qAMOmtDNmxTJe6iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(558084003)(71200400001)(76116006)(6486002)(478600001)(31686004)(6506007)(6512007)(4326008)(110136005)(4270600006)(316002)(54906003)(86362001)(31696002)(64756008)(91956017)(8676002)(66946007)(66446008)(66476007)(66556008)(38100700002)(82960400001)(186003)(41300700001)(122000001)(2616005)(8936002)(2906002)(5660300002)(38070700005)(7416002)(36756003)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWwvSWU2aDBMaGRvNGFXOVNmNnZuOExIYzluK1VMd3hWQTNUOXlyMlFoaDh1?=
 =?utf-8?B?U3lzUVNzTlFZQzRvT2xoZTRPb2JXeDdYUUV4WnVzNVpRWHlsNFM3TncxWkli?=
 =?utf-8?B?QXMzbytrL0d5YkpLV2dadkp0UTc1VUdlUjdYNDlCTWtNVVZ1cEpwQnlUb2pZ?=
 =?utf-8?B?ajU2VnI2YXdKLzc3REliekdNNTEvYjlwMjlLSHEreEFIakpyMG16emFSYkxj?=
 =?utf-8?B?Rlh6dWxhM3g0RG5KL2RYUFhMUk54S3ladXlHdlhZUmhIZVhvc3dQV2s2WmZQ?=
 =?utf-8?B?LzM4VVY3K0pXTTJRQUx2SUp3ZzBLeWF4Y1daWnhoUFdzTEZ4ODZVbkdQbndT?=
 =?utf-8?B?V1JmZzA1ajA3RmNUQUlXRlhUV1R5YjZwaCtDWEMzc2JPRFdGZExHVGxWczVw?=
 =?utf-8?B?S2h6MkxTTFBEeVFjTXlvKzJLd0lsbENGN1BzWS9hbjRJUjBKaTlyMS9IcVJB?=
 =?utf-8?B?bjZxNG0rSnBCSlhzZTlPdEpDaHlHZXFvVWE4YmViWG1zNE9LU0dYYjZXcjZJ?=
 =?utf-8?B?aUlUbERvdnQzQ1B2NzZqa3RKYW8xS21xY09XaGF3MDRTTEJvWVlsbXFWeGVP?=
 =?utf-8?B?VXlGNTg2cGtMRTA3NFpSUHVGcHRmRnhzdzNDeVhEd0tYK1FwdDV0enBGejlX?=
 =?utf-8?B?YTRkNUIyV3hQc0RFNG4yMjBaajVvdzhaNFVrUG94VDJGeGZ5end1N1dKOUUy?=
 =?utf-8?B?R214QS9xbm9LY0RmRjZhNndjbHg1UUxYWEpOYmhRSnZ2Sk5UaVVTQTZSZ2pw?=
 =?utf-8?B?YXdsOUoxcm84a0tHeGM2ckEzMWhJZTVjSWhsLzFFR0tkQXVCYThyWUJ3MXZU?=
 =?utf-8?B?bEFIZlRud05JVGRBcWV1TERGdUJTNURDTHMvT2YyOWJwZ2lEWmdrdlF5cDFl?=
 =?utf-8?B?VFQvS3VSajJaRkZFZHNOOTFCQ015UW1BMm85VS9TcGVBM1FJcXBrYTBlWDRV?=
 =?utf-8?B?N2tEbGVMaGs4dS9xWnZBL3VmMXU5aUdML2p3OS9nSlR2MWFrYXg0UlpJeERM?=
 =?utf-8?B?Zk13YXdzdFVuWXQxUmlBa1JKcXMyQ2orVHJzek8ydW9mZjhLOUd4MnVDSjJV?=
 =?utf-8?B?TTZMN2hEeUN3SlNpL0J6UW1lV05PVDcyOE5mYXBlWGJDazlTWC82b3dtY2NM?=
 =?utf-8?B?Yk92cEc1MWV0UHBxQ2Qrb2U2MHFWcGZxTHliYkFwcHN6bjdOK2wrZEpYV04y?=
 =?utf-8?B?K0ZoRkY2bGhFTkpzRnFrc1hLbmE3bWt3UU9yM2EvMzN1TVVhM1h3ZDIyVm9v?=
 =?utf-8?B?UVhSb1lVVnVOOURwTDluUUxMNElmdUZoWm1vNWNLZXBCeG9lMGxRYmRpVEVo?=
 =?utf-8?B?aXZVd1hTVDNaVEcrdEF4L2RWTXhtUW1JNUlyV01MNFZBa1FTSlJFVWNBSkc3?=
 =?utf-8?B?WTVXcUtVdmEvZ0hGYnR0VjBTOWJxdHZhK3NHczVlYzQwQWJzWWI3UEFqZW8v?=
 =?utf-8?B?SkhOeFJxRHBqeWN2TDNXQlUxVDdPbEgzODBUMmt6V0xGNnNkYVIvWWFTUDM1?=
 =?utf-8?B?SXl3YVNadHpUM1pPazdMVytUOWRiczhqNm0xQ0l2SUw3SnNOc1l1Vnc1c0ll?=
 =?utf-8?B?a1gycFZNQ1lXRkdjZW81d1NCa2JuYk9tb0YyRkdHNUFVTSsxRFg2VGZ5eito?=
 =?utf-8?B?ZFN6WEZ0dVp0NmdRLzllZFVsU2dNMHkvKzVqbjVWMHJiemx4d3QyOSsvM1VV?=
 =?utf-8?B?R3VodnRoUGRqWHpWTTZmRVJzZjRNMXhZS2xORkl1WjlVZlZaNnI1WktRRUFD?=
 =?utf-8?B?WWpNNXF6cDAwb2RteDR1dzA4a0xLc3ZMZWdEQ281R0N6WkJLaUVRZkFuV3JE?=
 =?utf-8?B?SW5zZ1IwUkNOeHNVSjlyMHhMYnZ6dWhzcnI3V2NYQmFQa1dYSGduc2dCemxF?=
 =?utf-8?B?LzNSVm11ODVta0ZBeXZpVGNxNldBZUpWYkVWdW9pTjBYM3ZRVTR5LzRlYWc1?=
 =?utf-8?B?UmlRVDh5UllCcXRwSEVJS2VyNm5SRFNWc3IwSEhPR1BnNHhtM2RaNC9jOXN5?=
 =?utf-8?B?SmdDSW5QWGZiZWM5VlBhczV0M01jc09CZTRGenU3OHlTcjJ1Yk9NZ2xiaDIz?=
 =?utf-8?B?RWszZjJMdkpTTElaOWhZdi9VOGxZczd5dXZ1VFBMdjQwQ1Y0WlJlbmMwQ3hF?=
 =?utf-8?B?cGZKbjlLRDlkQ1NkSytRYmp5QWhaR2NUWDJWaFA1NFZaZGdkTzhIOWVMRk1i?=
 =?utf-8?B?M0JmbStZbWFJYW56ajZ1WkRIakRzVDhJSW0zY0o2TUxnLy9YMkg3ZmxXT3ZZ?=
 =?utf-8?Q?zj6LS24I/T1SwcWRPLhsK2CqMXcLpS/aVTmNR8hpUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0A0DAE71C3DBD44837403D6E23AA15D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OGdmcFBQbVlZOTEzNDNJY3VudHdqaWxOK2EzSWNLN0FONEovV2FNaFlWZFBN?=
 =?utf-8?B?SHpRYUtpZjlNT0RRTXpIdS9SeHJnLzRnVkJTdjJuZDIwUnFNY0VsUUVhN2Ni?=
 =?utf-8?B?M1QvSVB0eEdsM0FXTGhJMlNBQ2d0Q041ZmVOWmpxUUJoM29zaUtjQmtSLzAx?=
 =?utf-8?B?VlRNSjlpVkhmc3JEeXZMWG96OWtiazBFR0JGUnVub1VTdzloVTIrbkNHMjlI?=
 =?utf-8?B?cEdCNEJJcUE1WnFhRUJyZ1YxUHhVb3lyelVQeDNhOHFrek9vR2phQmVUVkN5?=
 =?utf-8?B?Q01XdFh1enVvblRhYVZQazBhVjVvamtWOS8ySHErWC8vclpWY3E5aUZhUEhN?=
 =?utf-8?B?QzBzV2x1ZTZwd3hzWmhZdDVNSVQ2dThWOVlDV0krakZZYVBXNDJ1ellnRkhU?=
 =?utf-8?B?SzNiekxrRWZ2Rm1NT2NjYTlpNHdHdGpKNVJTTGJBYnZBSjF1UTNsbGNJcW85?=
 =?utf-8?B?OGVrVHBlaXRuZzUyTm8rYkM0UmRuSHluWnNLYlY5QTY0STRTRjhIQU1qMHBL?=
 =?utf-8?B?cUJHRkZvcTgxN2ZyVjlPZzJpdHcraE1WKy9DOXcwa0xOOHUrY1lEZ3l0OVYv?=
 =?utf-8?B?ZkZZM1hzbDEvOG5IWm5YaVJNY083b215RkFGb0dIMmlzNHN2eDRJcm9iSDda?=
 =?utf-8?B?aDJ3MHVKR1NXa1k0bU84T0tEWkc1eHZrbTZOTk9iTGpPeDlYUnpPcnpFR2J0?=
 =?utf-8?B?MUNmUER6aUZLS1BFY29nblpheUN4cVFnNkM0S0ZVMTJWZ05sM1FCQ3g1U3cv?=
 =?utf-8?B?NmZXeFBXTU90bitWRGZDTkwyNVZ3VHp2WU9mL3cxUVVwZE1QejJqblBHWHBO?=
 =?utf-8?B?LzRuM3BoeHB6Zkp2eXpsSWJETVlwc2FIM0FLVWdNZWlCa0RkdmNneU9ROWll?=
 =?utf-8?B?ZHVMVlhUd01xSTluUVE4Sll6SGNTNEtQczhWMFVXSWlDYkxFYmp2NUx6WVBo?=
 =?utf-8?B?S2tuMGUxZkY4SFV6ZU94ZXpvRnBpNnJ4ZUZVVjMxZDNVVWFtWlk3alI5SmRm?=
 =?utf-8?B?R0h5TDdjVmVBMG1LQlVSbmlMblRTQjQ1SU5Pck8wOEw5RFJyWStrYkZ1dS9W?=
 =?utf-8?B?RkJJTVB1KzlrelgvNHJLSlJNWmlrNlcvQ2FKdCtGVkUxUmJ3THBVZnVzTzQr?=
 =?utf-8?B?WlRnbkJiTlVKOHhUVWFZNXJPYUdQcWZIOC82MDhTZ3ZVbFFqbWcxK05LZ2Zv?=
 =?utf-8?B?ZEdqNzNiTVR6cldiRDR0RmdHMnpIanRLNmE3SjQ4aGlUcWN6ZHhlSEV0STJB?=
 =?utf-8?B?bVZUaFRwcEFOZGFKa09VQ2I3WkVqMjVhZGw3VzE5ZDRIODNmWU9GQkRzSGNy?=
 =?utf-8?B?NGg2ZHk1Y3BvTDNaTlk2YStrekRhV2NPdXZUaHN5LzV6aVREM04rekx3cGFU?=
 =?utf-8?Q?T/yP45y9YiehwhF1Nwj0qPQJ5JdBAdV8=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8271505e-ba5a-45b3-fa3e-08dad77f8ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:46:44.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz2WqznsJgIqwxdITNqa0Jw3dC69XHpyfl++UOMBTHg0Zff1TWiFHyvwxTwFvScMBG/ExWb7E3Cfy1z/bVJnGFWsd8D2MPILdcQa9fooY9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8231
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
