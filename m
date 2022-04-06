Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0F4F6AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiDFUEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiDFUDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:03:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3651903D1;
        Wed,  6 Apr 2022 10:34:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236HPHCC024447;
        Wed, 6 Apr 2022 17:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=glAD0iU+ISuAoR99m/B8pXCWyQkBbQ2Nx2DtUQCjz+4=;
 b=FZODeqiOJbUKhNyjsvByssSQFhT0KORsDt6YX3HA5jz3ZWmVOqD71HeQuPdvxlt/+cj5
 aBpkW3BjjguGR+XsaI3vFcDLK1ovOcOpW+DzWSIvOr0zy5Sz2y451HJ7bahI2Lnn8vvQ
 u+fIqA9SFKQhhf+MvfraCn8EIgpEz4kt574DvEV1KSSL4z1CQFJxf9dGOzelJgOoSaHv
 QNpE6p1uH0fCMTeUVyO0zSqy3UnFQOu1F9/1NOksJTylbM8gEjHbmOfTBiGmrDtSLtHU
 FDX6Q7lpuRR7qhkFUdKo7LNdA79ApPk7F+AJPpWF2jHCJd+eSjBqt083Sz6D8Mgn++92 IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t9sps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:33:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236HFYDb039625;
        Wed, 6 Apr 2022 17:33:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tsbw9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr3N2o7fYd6BWmFaUmOF/bP8w/Rf+8RhfgWE3rN/zD4t7W2b05kiG559ZyjOq3C8Cp2m5bYx3swDY5K76aueYJbxStHb9swHb9Lm+T7jSi6TvHVLq7Bks8X2XNtplpXJjua2MHZp5nhY9dNADdH3NfQ2FAxLsho8LG8s2oKh29Odjxlxo4UBAMCcS/6u57bd/zhADsBehIzNdZkCe6ExskS+FLJofKjScFvlt1ik2lFNoNn/XQ5qGyX8BUKAao1ttZB5U6284QvtAxnYBrBxk7MHvHozP6lSS62uYD483J+OAJe58JNi+3/j+GvozV7KMPBFH/7SLDcUS8sbFRfH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glAD0iU+ISuAoR99m/B8pXCWyQkBbQ2Nx2DtUQCjz+4=;
 b=eim1n+4Iq3AlnAubOW9hvRZ2BLrbGSL78Px2yqgvPF0esjpNfrukrK2I+ibYvdyA6uhrjApmNkcrCWNFjI1XRn+06fGjdHAqsd1FJT7OrdjGDrjDWrKXfSAcLQKXoT3YK8AciHknM1OJLpV9HQZNSE7JRGBZa/sCNLqn4AJCYPYfP24lrWX6km3ETc2tfF6dN+3AOb3TrwQB3CGVFSJBZ0lgEWCzhjrnsoT77Mkg4i+6JHYdD6CGk8vj6pz951uQRAAOSriqrIQbZEAxLRy6aJeJE4KcUVWpxwA3L2Fq8PYpDtL8rfkUlbDr/X+hzHHvp2PmK2rwh8Ukjw+zj4Wy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glAD0iU+ISuAoR99m/B8pXCWyQkBbQ2Nx2DtUQCjz+4=;
 b=L1RtcL5yX0GFJd6n0Y76n/xSCPGJdgqSEW5Sa+pJqcwcQOccN5lR4zkt/1gdYwFhuiR8Y1rLcFz2q6ql+Q6cS79IrahcCCs3Hd/rwalckLRlGpHvFnfN6BP8MHOQzlo+LbuqwOp6Gi3h/DqV+9zXcnDV8BM9cXThJmNOxkr0Tn8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MWHPR1001MB2142.namprd10.prod.outlook.com (2603:10b6:301:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 17:33:54 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 17:33:54 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v7 6/6] pmem: implement pmem_recovery_write()
Thread-Topic: [PATCH v7 6/6] pmem: implement pmem_recovery_write()
Thread-Index: AQHYSSYi+xuR0MG2lky15yeHiEHmQaziWhwAgADMj4A=
Date:   Wed, 6 Apr 2022 17:33:54 +0000
Message-ID: <8f9a33bc-f4ae-0cc7-3db6-a516f246ed14@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-7-jane.chu@oracle.com>
 <Yk0jaC9rHwwoEV11@infradead.org>
In-Reply-To: <Yk0jaC9rHwwoEV11@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 142e4883-27ba-49de-5e95-08da17f39f54
x-ms-traffictypediagnostic: MWHPR1001MB2142:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2142F46C1FC45C6276E227C0F3E79@MWHPR1001MB2142.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhBdfaY58mKEJm/gpEEhCMykC6QJWYybXkmDWpRpWSuMKTzUVd8DlIV8d07cypbcxFmrvWulh3Rz25lAUbIX893gxymkv0WssYl7RDCtHMytzJI42w90zOEi1/j/hCu7ZUy5etlY3KVE38pNd8Ba7Pm8C8+cuVBxT/SbBGW+sZHNwMDa8IBCa6PNHSAVwJyxFH/56uExCE7Y2SLJOHLNrF3KhwMG0lCvzxPrQccp37cYTYItic3S9Aeyw94QXORRvnOF4h61oLMqRAZS2rPvCfcYdmmiKPI9vdIv4ivktCNe8IOl5MbtC18n9XF7gZiACUxQchVxoD5AtpaJLFDbXPlX5BvTBn0G3mS6Scy80JApZBgfdQFFq5VyhSAMncyfteoe53CPjkc+8uVrcjm/RQqyqEINJCZGFcquxUFiF/bpW/H5nOCi46HsFyOj69QyPiHC/BzcYJwuCxj7gNA8WHKZrl3iSQX7ZNfW0U9fRWTz9XxAoR+T9higy62DczuxMd/6AcZyxR8Gy651RoVLuPjLC59E2sUKqmvL2SJDV/IM8eZm1pRFvvune6qfzHLbmS+yXeO/5QmghSjFxJN4apl0sswZmZsP23zwCaqZ7JWyfrZarTTUVtr0LSJZUX9Bsu2vn58lMoA8wUVfCauShATPMTaOI1/oz57nE4JfnchaZEx3PkPKE2nNg6z8HY6bFiVhnr9OgNCNMSpAPLMHqaxQEuRsDqgFb7msysXE/YJHmrOrvzWd6ikzRmZ8qZOhECYFP+1AB/9e5bpxt6OuHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(64756008)(4326008)(186003)(76116006)(26005)(66476007)(66446008)(66556008)(31696002)(2616005)(2906002)(4744005)(38100700002)(122000001)(5660300002)(86362001)(7416002)(44832011)(83380400001)(316002)(8936002)(31686004)(508600001)(38070700005)(6512007)(71200400001)(6506007)(53546011)(6916009)(54906003)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzhrUHhGTW01SFlUQ0t1REl2d05GS0F1V0JxeXh0bUNSajVYRjFzcmtWUkFN?=
 =?utf-8?B?amdHMXZlMmgrYmdlalRSalNleTErSWtGSVVpa2k3bnp3elZYMG13TEpUZnV6?=
 =?utf-8?B?SmRuamRHL2JMK3h5OFRsam9wUTBibHN3N2NFZXhDMmdGeHZiNXIyYjlJV3Uv?=
 =?utf-8?B?WEFBbTJpbml2eWV1VXgxdWdJS3IraEdkcnZFNk5HVWFHdzloRWRnYTdKQ1Qv?=
 =?utf-8?B?SDFhNUl2TTN0dUxWUjFVaWg3dUJZQ0VYL0F6TkwwSGZNM1YyTHlESU1ib0Vi?=
 =?utf-8?B?SGhHSG4wb0NPQUo5NlFoVVZuNXBBaXc2YmNJNDRTb2g5dkpIUHhWSVlsc25V?=
 =?utf-8?B?OXlMcU01QjdPM3JqY28rN0dqakQzUnhhQ0RSUUNhcG9DeTNxR1pIT3N5TmRK?=
 =?utf-8?B?ZWZqbENtazJHOGpBVHBWZ3JWbEhPVzRaRGlBRloxalpKT0lWOHBJbVROOFRv?=
 =?utf-8?B?V2hYM09NTE8xaXpLaDlibGtNckJHQTM0NkxOOFhuWUxRei9zMXViTWZrNzVJ?=
 =?utf-8?B?TWxBT3hoRS9xb1ltM2JpcW92RURNWkdLd2R1dzRBRy9tbVhwdEpCVlFORStm?=
 =?utf-8?B?OVFhTUkwbFE0Vm5xRU1NK2FKVnl4cTBubXlwQng3c2p1cjVIUTZLZVpuQ0Er?=
 =?utf-8?B?dHJDcmpTSnA4THlmdVl4UjlXYVBGTGJiSE96dElZeC90WUpna3A5RTdQVjJP?=
 =?utf-8?B?Z1RRc0g2RzJZbVNFNjRoSHkweGRZaERGSEVjRS9vZ1ZkdU1PS0NKU0R4Vy8z?=
 =?utf-8?B?eEdHQnQzRGorVll6TTZKZExtREhBQ3BZajJyKzJzenBoU01hSnNycUlMbWw2?=
 =?utf-8?B?ZkpickpIRlpOMHJOeGRVc3VjTzQ4SnR5bjBadUtaWFI2eS9FUytzdmdpTEdP?=
 =?utf-8?B?Y290NExXSWJuUVJ0YlNFd1JZTVVXWDBLMEpSeGpGNFZ1VzExNjJKSW1ybFhX?=
 =?utf-8?B?MS92aDEwTVQzU1RCZ3BOaWtsVVB1RzdGS2ZQUzlQVWJrNXR6K2dyUWdEQ1dt?=
 =?utf-8?B?MTBIbVI0bngwMUtUZ2I3aWE3NUNLUEtZMmQrc2JiMGZUTlM0N053d1lMcVpH?=
 =?utf-8?B?MVRpVkxNRnkzYnZvSDhSdnA0bmVNVzhmeGR1c0lEd3NxRDhaUlVvK2tvWHk5?=
 =?utf-8?B?RnZVQVVvTGRwZkRRRityVmM0WEp0UFVUVGxpNVRmRUdOWUhZaDZtSk43QUJU?=
 =?utf-8?B?MDRsSEFjU1Z2UnlDdk5YQkR3TFJqZ1d6bVVCcVdLcHd3WlhNS05sTU1rV2x5?=
 =?utf-8?B?SmlUMWI1djFGcGViWFlmMkJ2NTN2eEd0Q3VjUjVoZFRINm5CeExmOWVkQk45?=
 =?utf-8?B?eEJDVjEwY0p4ODJzdi9BT1BJU08waWd5c1JmTnUrYnZnQzRNclI5WG1pNEVh?=
 =?utf-8?B?eWUvQU9nK0NLMmtpUmZZRjNjMEk4ZFA0ZTZEODJJdDlHaEgwa3JEbHJXaVM0?=
 =?utf-8?B?Nkg5QzA1NG5aV284THl4MDBqY2JQTEV0anMvWFI2bGs5Z3VCNXFMd1ptR0NB?=
 =?utf-8?B?YmRqalVTVW5LaVhjdndyRUxXZlV3RmNza29QcVVzSTVrU253S2U3Um9UYXky?=
 =?utf-8?B?V2VtOFVrU2pWSVBxVjVtZnFXbHRRSjM0NmsxQXM0bFl2REZUZW4wcjFaSk9z?=
 =?utf-8?B?NE1vUERhSUxkL3ppVFFFMkhRNExhVGtpZG4wSEgvVDV4eDdtck16ZFRnaWNh?=
 =?utf-8?B?bkJGbVhlS3Zmay9VV1pnbTFzVWNQRVZGSVNodURENy95MHBlRW42VkkzMzdF?=
 =?utf-8?B?RnZqVDE5b1plNE1Memg0QjFsdUxMMGRndURZaXhzdnB4YU5DWlBhZ0I5UGkx?=
 =?utf-8?B?OGkrM20xZktLMGx5K282UXlZUDNrcGZlKzRGVDFINDhOTjNjbHhRZWpiY2JK?=
 =?utf-8?B?SnZmaExaSUlBTzd6OFN4QnRxTFMxOE9mREh0WjlKMk5xd0xRdVQzUXVUMm1w?=
 =?utf-8?B?QVlTcVlLdUFpS3NpK05XcHoyMmNXQjVBZ3RBaHByT0J4SXcyUzNBOWdKOTA2?=
 =?utf-8?B?NU41ZW9rT28zRTgzb2NTNkFHb3Ywbmd4d1IvVy9LRUx1TTVlVEYzUE40M2Fx?=
 =?utf-8?B?VFJPTE5YaFNGaUNIVHJFRGhvdmtjMTBDTTVkUFR5bUpxN0MycnJVTW5UZW1o?=
 =?utf-8?B?WDVYZ0J5MnVnUCtXZERhWUVybm9wSEliUXk0UlVibE1rMWF2NTdPbmlZenJD?=
 =?utf-8?B?UHU5VTNqSGI1ZGxZT3pSc0MzRUMvRGVZODQybkxCSWc0ZFRFaG9YNCtkb2hp?=
 =?utf-8?B?KzNpSWswSkRaeW5vZ1lIUmlMVU4rdDdYRm1ydkhQbW80TDhzbGRkWVRkOGZF?=
 =?utf-8?Q?WhawQW51WoVArU5VVs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E76FF98E74FBF54DB967651B7B9E17D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142e4883-27ba-49de-5e95-08da17f39f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:33:54.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9faPc+9OAuXAlVDq95ApMSupLNNW7qBFDHXfmacA0BLZLKauEDfVokfKqlwede39942nwh+SmHV4aAfCR/HKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=826 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060086
X-Proofpoint-ORIG-GUID: EsFOo11MhzS3hjK_aVyPsNAgRbzyT249
X-Proofpoint-GUID: EsFOo11MhzS3hjK_aVyPsNAgRbzyT249
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC81LzIwMjIgMTA6MjEgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUs
IEFwciAwNSwgMjAyMiBhdCAwMTo0Nzo0N1BNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+ICsJ
b2ZmID0gKHVuc2lnbmVkIGxvbmcpYWRkciAmIH5QQUdFX01BU0s7DQo+IA0KPiBvZmZzZXRfaW5w
YWdlKCkNCj4gDQo+PiArCWlmIChvZmYgfHwgIShQQUdFX0FMSUdORUQoYnl0ZXMpKSkgew0KPiAN
Cj4gTm8gbmVlZCBmb3IgdGhlIGlubmVyIGJyYWNlcy4NCj4gDQo+PiArCW11dGV4X2xvY2soJnBt
ZW0tPnJlY292ZXJ5X2xvY2spOw0KPj4gKwlwbWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBt
ZW0tPmRhdGFfb2Zmc2V0Ow0KPj4gKwljbGVhcmVkID0gX19wbWVtX2NsZWFyX3BvaXNvbihwbWVt
LCBwbWVtX29mZiwgbGVuKTsNCj4+ICsJaWYgKGNsZWFyZWQgPiAwICYmIGNsZWFyZWQgPCBsZW4p
IHsNCj4+ICsJCWRldl93YXJuKGRldiwgInBvaXNvbiBjbGVhcmVkIG9ubHkgJWxkIG91dCBvZiAl
bHVcbiIsDQo+PiArCQkJY2xlYXJlZCwgbGVuKTsNCj4+ICsJCW11dGV4X3VubG9jaygmcG1lbS0+
cmVjb3ZlcnlfbG9jayk7DQo+PiArCQlyZXR1cm4gMDsNCj4+ICsJfSBlbHNlIGlmIChjbGVhcmVk
IDwgMCkgew0KPiANCj4gTm8gbmVlZCBmb3IgYW4gZWxzZSBhZnRlciBhIHJldHVybi4NCg0KDQpB
Z3JlZWQsIHdpbGwgcmVmbGVjdCB5b3VyIGNvbW1lbnRzIGluIG5leHQgcmV2Lg0KDQp0aGFua3Mh
DQotamFuZQ0K
