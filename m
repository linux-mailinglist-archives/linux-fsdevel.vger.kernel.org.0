Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494D678195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjAWQgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjAWQgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:36:18 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D32BED6;
        Mon, 23 Jan 2023 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674491775; x=1706027775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qzi1Y/6boJgZmXKCx6iTq7uG/g+Bmr8uGUwxxAkl8+o=;
  b=dxBszh7THtl2FTGeNUXJiodGns9He0MqXtQv9eiwHG0qyBhsAy0yPvS1
   fLqYEC0cRZgD9fNwHNSuZdGucNtUPhMNVnfl84yVNS3ToPJG/LQYc7dfT
   N+PlrclxW9vcB4zYSTGSl5PBrbSEkrQXGDgSXJqKzAaRBgbccieGTJLbT
   X3TjrqmmIWbfxed+8PoEFK11SSrdW3SQSPeO6wFrzf7yubCmfelvW5u5a
   1asQpsdp8hhGSlPUxAdvARQ4yLcPabIQNvbdfwI9zBHKvxgmNI6uBNXta
   VV6xmQCleIje/VOMUaLowxn3Pp1j9E47E00XckQlJC+59rvsy3BKcMDeu
   w==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="333551584"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 00:36:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcAzR5/J4qp0cbdUvG86qFHNQ1meGz8Uy96ku3VOKahWYvyuo7ZOditgNzEW4luscrMKelqbkbESotrwy52F3rG964UonFfrwL0qm7DablaTU2G/cRC4i15aHsYeNFDmZuRcs/rvqhQIzgOq9jBeWithPRkgN1K1m++Osw8wS7YPwVgJvv8OJO6VVQp1+EBOMdt1VhiFgGsRj3Z+2zhPWpO/pu3fcDuOWuRSrAsbvEL+U/0vzsSPfDL55OU9LBU0r+Ik50GHa8OgHDOWQyH7O6um2KSGrB1xn12QK4Oy+IPGTzcipS0RUiW3P6dFDrfVOa7JdDsTg+WAQhAYoFzm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzi1Y/6boJgZmXKCx6iTq7uG/g+Bmr8uGUwxxAkl8+o=;
 b=U/gSj1+NbxzuMjvAXnCez1XGsK98pVp+o3K2FhBjrqTbHJtc/5M2TiX1UjASnF5/APUForjCINzKAnUUaZyOksjE+ldSqqb39MpT7/K3U73SS+cBV4rUUABDy4zyihPtBe2SpuOE5Rz++FXiS6dhwiQYp+9WRUCvqeUtHAFO9FAQKIksj6XAfDza6ExiGK6p+kGIIDOlIKcaSBCvR7a3rZqRHpvMB+hhU4rBg+Yock1zz2mTsyQ4ICI/sqrTyUbGVAhQG0jcGaZUYKKnNG8RkOP1UyuvYnmjOyo16spYASyxMgdDW6qsP5UU0keYMUM090wnde4jvHGCWgw+ow+gCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzi1Y/6boJgZmXKCx6iTq7uG/g+Bmr8uGUwxxAkl8+o=;
 b=zNBrKS6rVkFxrvzsNeP3nfd9cv/4mf+Mhv5p0azg21mlBW3cTzCBxAsqaIwc1NJ2xyttwCAz8hih6EuQxMwdtgZ7f/Yk3zSq2JcFRAYkv59Pu9psHszB4UfkHACsYeK6HwxK/JBKCXUOHrtE/RxUldA0yjx6vGAWc4MsLcoUdE8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7901.namprd04.prod.outlook.com (2603:10b6:a03:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 16:36:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:36:12 +0000
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
Subject: Re: [PATCH 09/34] btrfs: add a btrfs_data_csum_ok helper
Thread-Topic: [PATCH 09/34] btrfs: add a btrfs_data_csum_ok helper
Thread-Index: AQHZLWS7KSWjO6BDMUeFI/oPw0rusa6sNtCA
Date:   Mon, 23 Jan 2023 16:36:12 +0000
Message-ID: <85ec5de3-d4e8-6e94-56de-dbb8a0431497@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-10-hch@lst.de>
In-Reply-To: <20230121065031.1139353-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7901:EE_
x-ms-office365-filtering-correlation-id: c24ad9a3-cf96-4ea0-d871-08dafd5ff05d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpwWK3EYihRktaId79xakDgD4MPX+BIeugqDdgCbypyXoOyLUBJhN2N555nd1qhle5E+XEyqYvXmMvaYmPPDz9zQ/zFj+QxbIOOOVT584DDGolguegDIk3osVFkY1MADy+ldaWnnRcf7k7ZhZJMwAgePBxxUq1eJMD/G2Ik/yzS4mL3M3pdC4fv9cD4vxFJdIm1pvZU+Uayq3jCjHGsIM7xz1kP5/hEt9vDciQshdxWQhDapRRRKJ7yMUR+J7N/15TBf8wlW3DxXGHN1duHbaR+0e9+xpZYZr8LLeF0buDtLyRDdEHovmYnR+6dT8GKfv63xZ9kkmCqeN9HR4UfP2u1SVzfB8RN8JDWErpmiMAQdieZr+CP44off7kWHIZqvmgFEHk8QwhyP7qX3cUDuO8JprINzrfMw0+9b1L67nGOztWTxiOhamrHogwaCrQ7d3aHj1IqPuExE3ZEj25kzDGFfxdiexlq1IhY7m9GUg8duS+hd4oobKfv+QAgF1mH+t/cLpMn9rhY9UJtNY6bZ7AP47FmEPDCvhkxwU5b1h8BErJYha1LTgeOyGFIM1mCDXI+FTb3r4PINiP4FLZZWW3qzFdiBApgR4TJTh6ZFbbniGE6HYfF23bWgkgTrEY04E4FDXjsOHIy2J6xrOPyWUDC8/hhEAq6ScjdULQ2EI855qsy2s/nbzdcgaU4Ed6o9n6iGjoIxRflEgHwbcaUBR+PDUpeoDW07BJ1OU+moivhibgit/vloRAwGZN8m46KMuQIvIvLbJXQxo6rT/xG8Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36756003)(86362001)(38070700005)(2906002)(38100700002)(7416002)(4326008)(82960400001)(41300700001)(5660300002)(4744005)(8936002)(122000001)(83380400001)(31696002)(110136005)(478600001)(71200400001)(6486002)(31686004)(91956017)(8676002)(53546011)(6506007)(6512007)(186003)(66946007)(76116006)(66556008)(66476007)(64756008)(54906003)(66446008)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FaZklwNzVTQVJ6MDBsNmJvR3BIblp5OEZNNnlOMklCMGJOU3ZaQ0s3TVdR?=
 =?utf-8?B?bHZYbEdmRFZiWXMvWnY2V0xnZUptMDdJbjhwbVhwTjQ1WUFiUnRmQS9yTjNo?=
 =?utf-8?B?S05RTzFybGRBdWQ4a3hEVEJmT1d4aE9lTzJ4LytyVEFLd0Y4aWhiUUM1eUNW?=
 =?utf-8?B?eEl4WGtSTEtqZVBwaE1POHNkdU5pbXhFSmtubXRyT1QvekJNcjFUMHNWZGhX?=
 =?utf-8?B?SGdiZTk0NnZmU0tndW54QnV0akxQSkdVQUE3Wm9DRi9SMTBjOUxLaHFLODZi?=
 =?utf-8?B?aEFzNGZJRUtVSURHZExMelJKZUJ1aysxVEJOd2ZiZ1R0UVRaNjV6N3ovWGxi?=
 =?utf-8?B?QXJRK3JIei9ELy93K0hXZFlCdEN1NHhDb3Zkb2phTWNlNEpEdTEyOG4rcWk2?=
 =?utf-8?B?VEJmWVRRcFM5RjZkd1V1M1ozcVNOM0hTQW1SeXRhV0JPN1h4Ui9ZNko2Tndo?=
 =?utf-8?B?cko1Uk9kZWs5WmZtR01aUjJ3TU95djBiVG41Szd2dUhzaUpnV2hadGN4VGVi?=
 =?utf-8?B?aHNoeVpHNFdLR3gyTjZ4UkQ2ZXlGSGlJL1J2aVFyVW9TMU1oSTd3TnhGUGZG?=
 =?utf-8?B?Y2g1NmhpY3BZR256ZFFqaGcwVVFDdTYvbk1ZbVppUHl4ZXNnQ2xhbVVnQ3lq?=
 =?utf-8?B?SnRNbWlteHBISHZZWWlXUXV0bE91LzRnZ3ZZRG4rR0xMZWg5Uk5nMUpKeGl1?=
 =?utf-8?B?QUo2OVgvdEc1dG5tRUE4aU1GL0x0L3hGbFc0dW9nNTVJZHY3VC9MeGxPSjVF?=
 =?utf-8?B?WWhrTzdjM0VZd1VDNTFxQmJjcW9YRldmbmNxbmxYVFdBVU9GcVBsVDh1Sk0x?=
 =?utf-8?B?SjBCM0JJM2lMU1RQSkdFSVMxNTVsV01aUFo2VUYzRHoyRTdWOEtZMUtDbndT?=
 =?utf-8?B?cWR3VEJYZG0rcy9lR0xkRTlwUmtoRisvRlVPL016aTZmcFBzdVRlbVpJMFVv?=
 =?utf-8?B?YWpvdzYwTnZPUFVReThNVVZnRUxHMTJZYWFqNFJKTDRTQUxlUGFQL0JWWHEw?=
 =?utf-8?B?clFwLzNQRVZtQkk5SGdKanE0T1pxRGo5Rzh4c0YzSjZoNlhtWU5seWx2WDd5?=
 =?utf-8?B?Y3RoMzMzN1IxT0tDVWFKUGlYMWxWbDBaVjRXbEh4aEZGSU0ya2dNekVaQWxj?=
 =?utf-8?B?SnZZNUNpQ2NkdEl0WTNhRndvbW11RHM0QmdmSVFmdWpaN3d6ZnNYOXFtUnBi?=
 =?utf-8?B?TGErVldZb1FsNVJ3VTFzcXk2ZzBvV1p1c3lxeDBDTk1LcUtTYmpyTmc4dDl0?=
 =?utf-8?B?ZEg3WjQ3SC9ieDRVWGpZWjRhQ2kyRXFsUHBaMzRid2pOVlN1dlZBZ1Irbkt4?=
 =?utf-8?B?Y3VtRzl2RzdNS2p3cUFISzd6QVVMVjk4bTFJcHRTMnIyaXVQSTVVMFZCYVhL?=
 =?utf-8?B?cjJKbjd1S3NjWlFwSDhLV3JjUzlYZXlqNWYxUGVWT2hZRFFhRFJCZVJxVkpr?=
 =?utf-8?B?Q0o1R1JUcHdNY1Zyd1FiaDhtbzdEbHl3MHJ4U1NKMXlqMWloeGdFNlVxckF1?=
 =?utf-8?B?OGJnUEtCZUd5cmZlSTN5bmF5VnRYNlZBSXB0Y3l3T2VUTG1Fd1djcEMzMjAv?=
 =?utf-8?B?SHZDQlp0NW40amROMmNPY2t4ZFVJS1VDeE1uSldtRC9KSU1oNGFpNUkveVph?=
 =?utf-8?B?bXpZVE5FUVNpVVNjRG5BV2FYSy8wcE94cTVWT3ZIWTU5YzJ3cnJxRmJlK3dm?=
 =?utf-8?B?VnlraWV1ekZBRlM2WTQ1QyszRUpsOUZwemRBU05TYVRraVE4MmtNR2ZNYWQw?=
 =?utf-8?B?OEk3M1VUWUlxRktvSlFaeVNFOTNXbHRWWEJMbXYyRWx4WEtYVkg4cXU4bVph?=
 =?utf-8?B?SXljQVpEYXVtYUllbVhLdkkrK05ybHYyaHhmOFpzRkpuK1dEM2t4eUdXbnZx?=
 =?utf-8?B?SHdYZWdmR1JCbVV1UVZWMnkvRHR3RlVKQ255b04rVUZIdUFPR1JRUjJtaVpD?=
 =?utf-8?B?ckMzQjF1UVBsNG9EODFHNy9mSUNnL3g0ejViS0JrUHRiMmxTVTh0VWlXd0Fa?=
 =?utf-8?B?NTRCQ05CZ3g1TURNK01yc3dZWUh1c0grc1JrS044d2hxTGcyc1FoTmlLSDli?=
 =?utf-8?B?Vys0M2Y0OWwyWEQ4NENwLzB0Mm1VbWxOc3lQdmhHVWJSUmJyVU81VnFPMVJH?=
 =?utf-8?B?K1BadGhpQlhnYnRQdG1Rb2tQdjdEVUh2YzlaZkdPMHgvL1VWeVRNcWZaMTN4?=
 =?utf-8?B?cWZlVDB3ZTR3b2pJblJsd2FzcW1OWkhoV2M2SGRvOGFQYTdrS0ZWaC9GUjJY?=
 =?utf-8?Q?X81s9AqbMgcAdf2wvG1XXWqE4Rl+8xL76SBJIF9cyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B92675DF9504341B9CC881DBFC546F6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TmdXUGR5b0wrZDdiNmI1TEFHd3hGVjQ4NnVjdU5weWdOWXZSd2cwMEhxUU0x?=
 =?utf-8?B?OGtCR0xVQkEvNGZ4dWlMdDJYZDdCRFNFSnRUd21FQ2orQzdMT1pkdkJjeE1G?=
 =?utf-8?B?NVY3bTI3dUlyeXJHUXNjSHY4Umd6bTk1THZyZmJqa29FaG5WMVdLTWVJOWND?=
 =?utf-8?B?UGFHYWY3VE1wZEIzOXN5cHF1UHZaakpSYmw3QnoyVmdIQ1FOcTdTa0g1RnFC?=
 =?utf-8?B?ZldqNTRyaWs3Sy82OGljNGpJWGVvd0NBOC83MXFzWGMwcW5jdHFldnJVSXps?=
 =?utf-8?B?Y0tvTkJna0pMVjUvemR4dGdTbTF2TkpZQzdOQVlua3NoeTY0enRGSWdLcUU1?=
 =?utf-8?B?eFFaVjE2bUx2WmRVTlBTT1phM0pBZW5TS1RtckVHdWxSbXB6V1RJNzI5Q09C?=
 =?utf-8?B?VDVrTDgraTZ4dHJ1ZDRia1kxM2ZKM2k3c1JTdHdpMmVieUF3S2VkT3YwQlpu?=
 =?utf-8?B?QlFKdjBtVXYxMmtjZkRrMW9RZFdKQXVKSUllYmlQVTJqdVJwQUxWMGZZUWdV?=
 =?utf-8?B?UzduSjIwNHE4dE44T2RzTURmLzVzQUpHMkFQaWEvOU51aFB2Mjh2OW9oZ2dk?=
 =?utf-8?B?UVNLQkxMQ2JtWVRYR0JWbU0rTlAyWHNXdFN0TmVwUHUxWEcxY2h3WlBKZHcy?=
 =?utf-8?B?Vmd3OUk0WkI5OFFaRDdvM3R2ZWREMTBJYWxkekZRMUJpRjZqQXVMNFNMTk1Z?=
 =?utf-8?B?Mk0raEc5aWFsVW5vb2NTQUh5eE5RcUo0STFGa3VpVjNOQ3o0cy9nREhyQ04z?=
 =?utf-8?B?cVcxVE82emxnTndNQVFEM21tY2dyZWJudFpwd1Z3aDJNTVhNa0NRaGVFRSth?=
 =?utf-8?B?R2N6SGFSaCt1ajViMDdlbFVrQ1NwaGV5S3ZVaUpVcy9PZzBMUzA5by9sTXc4?=
 =?utf-8?B?dVZONVBBN3RFK1NEVG5JMGorUU9DRFltTGc0MU5sT29kRHNKQm9XVW0yRWhV?=
 =?utf-8?B?d0o3YUNLYVpyRS96RG84Z1kyL2dwbXBPbkZxMUpaV0xNOVZ2V3UwYm44eSt4?=
 =?utf-8?B?eWRpR0h6QU5KVmsxWXJKM2ZSTWNqN2JnNm5UUkJDU0hsd3ZNRXpiZy9KbVVw?=
 =?utf-8?B?ZTNmMGE5NVhLM0tPcjNFL3VRMS84cjE0cHNsOVVmbGh1YzdZSExZdWdFdnRW?=
 =?utf-8?B?R0NpSmFBdEhsYzk2V0RDMjhGNmtVYVF6QnZXQWJSTm9HUE0vZmUwUXE1WnlH?=
 =?utf-8?B?aG5yVUtkL2tjaFJBRmJGNzRIZlI2Mlo4YVhxcmszY1Q2b3d1M0QzdUpEN0w3?=
 =?utf-8?Q?aZDz908GvijsJ5B?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ad9a3-cf96-4ea0-d871-08dafd5ff05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:36:12.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLnQ2w0vw4pokEsWDwfbUJK68t1CCiJfhtEwvoKQQ89tTEWsOEpn66L0hh7hEWQC5ZFEXYiVZTS2wwQKZo/tNOXfdrEp1spdRaXcBAgOGLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7901
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjEuMDEuMjMgMDc6NTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCWlmIChidHJm
c19jaGVja19kYXRhX2NzdW0oaW5vZGUsIGJiaW8sIGJpb19vZmZzZXQsIGJ2LT5idl9wYWdlLA0K
PiArCQkJCSAgYnYtPmJ2X29mZnNldCkgPCAwKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsJcmV0
dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gKw0KDQpOaXQ6IGRvdWJsZSBuZXdsaW5lDQoNCj4gIC8q
DQo+ICAgKiBXaGVuIHJlYWRzIGFyZSBkb25lLCB3ZSBuZWVkIHRvIGNoZWNrIGNzdW1zIHRvIHZl
cmlmeSB0aGUgZGF0YSBpcyBjb3JyZWN0Lg0KPiAgICogaWYgdGhlcmUncyBhIG1hdGNoLCB3ZSBh
bGxvdyB0aGUgYmlvIHRvIGZpbmlzaC4gIElmIG5vdCwgdGhlIGNvZGUgaW4NCg0KT3RoZXJ3aXNl
LA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQo=
