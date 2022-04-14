Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF921500357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 03:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbiDNBDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 21:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiDNBDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:03:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952342EF8;
        Wed, 13 Apr 2022 18:00:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DLIGjY001710;
        Thu, 14 Apr 2022 01:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hcucnvjuofk0qKW+xu5V4VYc0v9OtVLF15vgjqizcpc=;
 b=TNgnell+DxG3FSWWMv5Oj/GWFycHk/jASIvrg7i3hFKgaZ5aQ27LswszffikprxE9r5j
 WiiYCqXEaccbBMzxtvmT6xblRhkq+WBIeaRRnViz3Nb85ve9YILU+XmcfL3aQYxDD7ag
 NXtNgFPJ83+TleKxd4qGqKd5HBVBXTt/0swvti3IoLyuf4YDi5feqLTr5Yd2BYCsBrN/
 ncvyeQHEkWM0YOuEbn9tuUHp5Du5jF2ndXGGYSpev+olrzY8Opz55sSEqts0C7dIPyCc
 Bdx/4bMFRPyumwzQM/edaaHzz0UsCzq9f5vBcWcsB9EfyCwJg4OuQvIUf+Dx7kkMtVti vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2kgcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 01:00:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0vSeI029757;
        Thu, 14 Apr 2022 01:00:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4xx1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 01:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiaBo2Zo+XNNMO1kAmm3MxdlQG1l9OYNGLlrp4TtSZ/RGlvNKBj7fAMmNu/bldxYmB94M0JNPhtF7whmrH4clEi6sPIVmHecYLDBLwdc553w8dYsdtnQO+U+SJQzcnwcL864e6ORO1ftqRmhWZMzDM14BYU9Vk9E8JTmKyn1477mqi05+cPwh4Fve6tqgDYCqCfaEd1/fEQc07SMlZb+F/sffRod2vevxoOHApowZIExg9KB5p0ICYZyv2Xq3PlanSJTp2hbcW1hyJQamKTxbYQHonKzLeMPmU5aJzxcavSjW/s7mKPyEQr5g4gqajUzCroOIwvAs6HJmXhBEG+7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcucnvjuofk0qKW+xu5V4VYc0v9OtVLF15vgjqizcpc=;
 b=ay18hBIjrNWMZ93JA6xEeayOe8fz77wLkM0Wc/Z3mnNZWDWDfQx1BdOg/S6DTsamUGKa7pnQ6lHqA5pFZL12R+CguxiEAKtRD4SMw7lptnxb7NatInly5ZBHwo0kcz50BBuujf+HVMCan3UJz27RlfMJnQHEDmZW7UqOZIJgPHWL/ye9ZyFM4muVJ5A9HpnW3JXtySx1Pd5OvfXgoQNs1gO0nZi7viWBc8cxdxavsd/wdAVAO5rM1vs0sQGr0F03587K0HmcU+/M+c7j40CCweSKTgrO9vElO5U+AMaoPDNCabZzaA5pLwu/wPWEunAdbiElRp7uo1dQZw3n1yqPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcucnvjuofk0qKW+xu5V4VYc0v9OtVLF15vgjqizcpc=;
 b=jTVX0WEauamkdYvUEMkx4Mp9/XXITHQCXkFF0cS4hyjEoviCjFNwEOu5SY694JWLgQL3T56K4SbaCCG/WEriyT4kgVmUByTP9h9NVEkv89ddoD1/3Lw12i3BDlsJklg3qBkQEsj5/HNKHV3MdNdWESaY42wTznX3X27NBvmuUaU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3890.namprd10.prod.outlook.com (2603:10b6:a03:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 01:00:05 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 01:00:05 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 1/6] x86/mm: fix comment
Thread-Topic: [PATCH v7 1/6] x86/mm: fix comment
Thread-Index: AQHYSSYYGFAW2NTmbUWesvhenggRg6zsFCQAgAKPhIA=
Date:   Thu, 14 Apr 2022 01:00:05 +0000
Message-ID: <e0f40cd6-29fd-412d-061d-d52b489e282f@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-2-jane.chu@oracle.com> <YlVMMmTbaTqipwM9@zn.tnic>
In-Reply-To: <YlVMMmTbaTqipwM9@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93270fb4-93d6-4840-eb72-08da1db21d49
x-ms-traffictypediagnostic: BY5PR10MB3890:EE_
x-microsoft-antispam-prvs: <BY5PR10MB38900C855FA33FB705DBB74AF3EF9@BY5PR10MB3890.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKra7YdMCjejPGYlz8XU7yK8qVPAGKAIb6jMvDXWswtPpyqJ6LNkQctIjcuZUszY0RZrCjbrkdSDnhzxUkUWQbX3YGhyZP2jjL3UNenMw+eCCpaQBV0+xrtzak84ouWY1ay6UJ5IsCPAFYcGS5gp4guNdTb5cleJIS8CabCmg83jgsqvFSp/2CfX6AyvtTnrl9hPTravqdqK+ggEc6ZYP7MErifeN6Gt1zWXulYYe96tu1ZEvA1PPeuley4YMxa9fFH9cAqZnuVfbytzYgDCTC09mPVafOX1ch/xO1owS9qCoBFrhqSTy/ftdb5gQSHHSLhufec+u6NRLs6a26R7QsUKqU5POthVFZms8TfEnDs/mCelNoz9/aATCmx9azVtGIwy2eK1WRPrAMhy3vjoCQ5FU0LJnmsu+LTa39rwnNjeVjpgSC840NyilRdFy2N+/hAEltW3QfXj72yhgPiRoSvQSbh5HqOvY4lt4IZviYq9CZKwXWeZI7tMK1GxCKApztSpOMOlCBAxbEBrsUHHV0BiTZSv5dp6DdPmKd/MjgbtiTZthya/PDPjNbor5m61/eVn05jevQsLDTkxi1jhwXUo9wn6yv1ET44whgCoKndCgz29utejrg+tB+PBQMzbXXFyVi8g19xTHQED5nr2+10YaBvlmDNaOuCfSkBhvTiCOd2007o862MCCx6HF92K23qDmjUrG2apXdql5btubaRZbdFiCOrhB7enSRFdopy0BI7oEpk7lUOJ9jMavC12al0tRygHQ6BalufiQIcInQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(2906002)(66946007)(64756008)(31686004)(71200400001)(66556008)(76116006)(8936002)(5660300002)(38100700002)(7416002)(38070700005)(44832011)(6916009)(86362001)(316002)(4326008)(31696002)(8676002)(54906003)(122000001)(66476007)(6486002)(186003)(26005)(6512007)(53546011)(6506007)(83380400001)(2616005)(36756003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjU1OG1Lb0Y4ZE5KU0RpQjZuUW5RZUtUZGtETDY1RHRueG5JSzlGL2NhWWl2?=
 =?utf-8?B?cURWU2NhQnFKQVMyVUJOQWptb0RZMHVESS8wL1VXWFVOeDc3UFFJUlIvaHcy?=
 =?utf-8?B?MU5nVmhCMzAyRUlZU2w5eGVPMCtyMWhrVHJ5bW93LzAwaXJVK3RsUnpGQXdO?=
 =?utf-8?B?Z2dxU0ZrdXI4T1RrZ241MHJHdTZ6SzhDWVhtd3ZGQzZUQ0R3SDdNQVFjOTlR?=
 =?utf-8?B?VW1qWmpZTGhXTTFtRUxvMTJnL3YzMDBjRkl1czREbzF2TDlDNDZoTmxZU1py?=
 =?utf-8?B?SlBVSE9pb3g1RkxsWlk0WUJwVDc3N0d3VTFmWllmQmFXNUU5dE0zMzdJTWlu?=
 =?utf-8?B?S0x3OS9OU2pzRVdaV090VGt5dWlicU15YytwbHJtR1lzOWhNUTRtdjJXb2g2?=
 =?utf-8?B?ZWJ0ZXFhTDh3S0NueWQ3cURJZ0ZPb1BqS3NjREhjWk5MREQzekdvR0lMaFJ2?=
 =?utf-8?B?REJUc2NDTWZaVmJ2Z1pEc25DQ0c3TFFFVGZGTXY2d3hZSU5PVXduUlFaV01J?=
 =?utf-8?B?aWhqbkY3cHd4UFQ5N3dmeEFYYTBxeVRrY3VPUVJjWk9mQXFnd2Q5dWk4bVJV?=
 =?utf-8?B?b0VjZnVpeDlaTjZxNHhNRFFnbnY5V3Y5Q2R3S1lEQXlad1Z0SWI4MDZ1RXNu?=
 =?utf-8?B?dXo0aFFXRlUxcnNOcEJpcjEvS2lIWmU4c1VOdFVPNktlUVdhMFpYU1Q1S29G?=
 =?utf-8?B?Z2x5dExSaFpnaTQxcUZhOUpPemQzbStqN3d2bGtsc2lmZ3Z6a1RaVzcvb3FF?=
 =?utf-8?B?L1FocjdsVlZvRGZhdm94SWhtS3VTV3ZkanhBTlFIa1YrQm5sN2p4VGZ1bk5s?=
 =?utf-8?B?WTdNdXo3aTlib3V5b3hiNTFZK3JIVmZEbHdzMXpKaU9kcjljUXZRcHVNci84?=
 =?utf-8?B?S083WDVwSnNJaUFhOEpLaGZkd3FIRGxBU20vcDdvSU43WS9PdkRoakIxTnJG?=
 =?utf-8?B?NkdseXM5anJpQWNMTk5HcGt4dHM4MU9OYVhzelZ1WFlld3lpT0l3cE9sVXlv?=
 =?utf-8?B?MUlQY0ZlUUtEOHhFOENOWDc0b2g2QmV2ZXNiUDZ2dzgydkk2SFQ0eWFpc2pH?=
 =?utf-8?B?TjJIMFlsc01pTi9CUXRpK3VCWVlXQ3YwSG42YXp4OVJGbE5LOFJwUlNyQnRO?=
 =?utf-8?B?V09LdXQvWXp4VFpMNXFYNGFLNnJxbjlsOExyNlRqbUkwUFRnNHpyTnRaRWRC?=
 =?utf-8?B?dFg4aUVUV2xiV3pKWit3ZjZJY0Y2NXp5QXBSbVEwQXVTOFJqcWxCTENldjQy?=
 =?utf-8?B?cytEMy9aaElUanB5Ky9SZ0toMWFoUjZNMGdRc0IrWkZUWEtLZjVGTG5CVjd5?=
 =?utf-8?B?eEM3SmtMZkFydkErWVNadjFsSklZakxQbjZ0OGZwME5XNGlBeHBESHpzUkJ0?=
 =?utf-8?B?cDVUYVBHL0hrdWhYRXFTdWNVUGdkMXkyZTMwWU5OMFh2ZHA5RzU0VUFJNDdZ?=
 =?utf-8?B?NEFnenBhYzdSdFpCZlJ6Rkg2Q1JqbnlYYVNaaTlFL3BWYVJzQmc1ZURvdVBV?=
 =?utf-8?B?TGFZMHBBbyszc0h5N1htYXpwM1Vib3ppZWpBUEJNT0dibGxaS1doU3hBQ08z?=
 =?utf-8?B?dDV6NWg0S2hCODJRK1h1Tyt3YVRYUDdkTzBzdEJ4ZXVrV0ZCR3BZcXMxWVhD?=
 =?utf-8?B?UHNwNE9BdjE1Z1F3ZHZsNXVHZ3pCREt0V3V5VW5LUWpPOHYyaXUzNm5GeEZJ?=
 =?utf-8?B?Ym1XK1F2MUZlQ294VmhyTk1mQXJoTUU2M3pZYVNnSjY3bW93cHg3ZlBodnAv?=
 =?utf-8?B?cktKckJSaXdnMWZ3TiswSTNmVVh6RUJRVms3a1hEK25OWUd5M1YvbVlwWi9T?=
 =?utf-8?B?TkJzY0tyWHJ0cjR0anBNUVRVUVBEQURxeWIxaXlJbkNRSFNiRXhlWTJNc01v?=
 =?utf-8?B?VDhrb2dxdWxwOWVBZmNJR0ZSemlsaUl3bEYwV1hZT0xwcFhYM0RIVThSVS8x?=
 =?utf-8?B?Mm9aVFpNVzkrcXpwNXY3R1lpWjFlSDJqUFFYWHI1NVdUTVk3Nkt4VThybkZL?=
 =?utf-8?B?SWZCMG5VWmtpUFJjMTcxVGV3SHY3ZElnY3h6ck1VSHVmS2RNd0ZTUzE0VUNE?=
 =?utf-8?B?SVB1ZHgrYnA3R1dGdXJQUGE5U1dtcnBjNlppN2NtV0tLUVhjRHlXR2FxMCtp?=
 =?utf-8?B?SW9sMzJldW1tbWJQMy95anF3Z1BjSHJnenZWemc0VE5kVGdqYnYvdnc0Q01M?=
 =?utf-8?B?V1RzOVRmam8ycVM3N0RsYXR2TXRKellMSmluS2JtS3dEZkg5MFplazMzR3NL?=
 =?utf-8?B?WkxmZVlhc1hveGJuOXJzT1Bad2dEMFpOMEs5L1JRa0xVT2hDMjFkR2M2dXFa?=
 =?utf-8?B?bHlxYVN1TWFYUldIN0czMlBKcVRabVZpV0pSY2Nncnd1TDdJajZ2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A20886CCA0399C48A914D13C339EEDA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93270fb4-93d6-4840-eb72-08da1db21d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 01:00:05.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeKXrBvcAsPUA2MSzYelvMKy25jxNKYstAn+XIKl2qICeJyIU7fhqr9lFpNYyUBP0XfMBRnQuUGQRgnyXyFMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3890
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=782 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140003
X-Proofpoint-ORIG-GUID: rQ0trxTQRjXB26Yhv9rKNSObzDp32m3g
X-Proofpoint-GUID: rQ0trxTQRjXB26Yhv9rKNSObzDp32m3g
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMi8yMDIyIDI6NTMgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMDUsIDIwMjIgYXQgMDE6NDc6NDJQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBUaGVy
ZSBpcyBubyBfc2V0X21lbW9yeV9wcm90IGludGVybmFsIGhlbHBlciwgd2hpbGUgY29taW5nIGFj
cm9zcw0KPj4gdGhlIGNvZGUsIG1pZ2h0IGFzIHdlbGwgZml4IHRoZSBjb21tZW50Lg0KPj4NCj4+
IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gv
eDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9t
bS9wYXQvc2V0X21lbW9yeS5jIGIvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPj4gaW5k
ZXggYWJmNWVkNzZlNGI3Li4zOGFmMTU1YWFiYTkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9t
bS9wYXQvc2V0X21lbW9yeS5jDQo+PiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5j
DQo+PiBAQCAtMTgxNiw3ICsxODE2LDcgQEAgc3RhdGljIGlubGluZSBpbnQgY3BhX2NsZWFyX3Bh
Z2VzX2FycmF5KHN0cnVjdCBwYWdlICoqcGFnZXMsIGludCBudW1wYWdlcywNCj4+ICAgfQ0KPj4g
ICANCj4+ICAgLyoNCj4+IC0gKiBfc2V0X21lbW9yeV9wcm90IGlzIGFuIGludGVybmFsIGhlbHBl
ciBmb3IgY2FsbGVycyB0aGF0IGhhdmUgYmVlbiBwYXNzZWQNCj4+ICsgKiBfX3NldF9tZW1vcnlf
cHJvdCBpcyBhbiBpbnRlcm5hbCBoZWxwZXIgZm9yIGNhbGxlcnMgdGhhdCBoYXZlIGJlZW4gcGFz
c2VkDQo+PiAgICAqIGEgcGdwcm90X3QgdmFsdWUgZnJvbSB1cHBlciBsYXllcnMgYW5kIGEgcmVz
ZXJ2YXRpb24gaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4NCj4+ICAgICogSWYgeW91IHdhbnQgdG8g
c2V0IHRoZSBwZ3Byb3QgdG8gYSBzcGVjaWZpYyBwYWdlIHByb3RvY29sLCB1c2UgdGhlDQo+PiAg
ICAqIHNldF9tZW1vcnlfeHgoKSBmdW5jdGlvbnMuDQo+PiAtLSANCj4gDQo+IFRoaXMgaXMgc3Vj
aCBhIHRyaXZpYWwgY2hhbmdlIHNvIHRoYXQgaGF2aW5nIGl0IGFzIGEgc2VwYXJhdGUgcGF0Y2gg
aXMNCj4gcHJvYmFibHkgbm90IG5lZWRlZCAtIG1pZ2h0IGFzIHdlbGwgbWVyZ2UgaXQgd2l0aCBw
YXRjaCAzLi4uDQoNClRoaXMgY2hhbmdlIHVzZWQgdG8gYmUgZm9sZGVkIGluIHRoZSBtY2UgcGF0
Y2gsIGJ1dCBmb3IgdGhhdCBJIHJlY2VpdmVkIA0KYSByZXZpZXcgY29tbWVudCBwb2ludGluZyBv
dXQgdGhhdCB0aGUgY2hhbmdlIGlzIHVucmVsYXRlZCB0byB0aGUgc2FpZCANCnBhdGNoIGFuZCBk
b2Vzbid0IGJlbG9uZywgaGVuY2UgSSBwdWxsZWQgaXQgb3V0IHRvIHN0YW5kIGJ5IGl0c2VsZi4g
IDopDQoNCnRoYW5rcyENCi1qYW5lDQoNCj4gDQo+IFRoeC4NCj4gDQoNCg==
