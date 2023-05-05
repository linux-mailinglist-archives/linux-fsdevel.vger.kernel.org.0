Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAD6F7E52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjEEICu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjEEICs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:02:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D31815C;
        Fri,  5 May 2023 01:02:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456XWQY003843;
        Fri, 5 May 2023 08:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PwbSCPq0KSYN1c+4wI6VvlI1PAsKx1lw/yq+vSId+fs=;
 b=EqvIfvVy0yreA8JMrgDy8xhtQ0I4PaTYRyAxye9vEh71lzafW56yp7euSLrJCICPrbFE
 EV4hkyVZxcZ8WV7IJwWcrp+f+gR0J/X25e8b0C6p1fWZsJOuVy4eZ9ZDI+Nf1NMgQDBB
 P2UEUlyUPwdyAaRdDv2VcbrpiCRqG9MglYBf3n7Bp0ktrO3Dd57Ka/otgJa34QmdbB3/
 TqAAVKDF6JzwcwQ8IcxtdiKWp0HiR0R1CWDBSn+WxHimwHSJGrXPIKMxl+PntuEbwA4J
 pgVsZN09z//eLWfiSPX7u3wc2LIJm7dL8za5a4u+ymbZIvF4DvK0U6Q4n4M9aOrUNydF Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1v3rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:02:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3456wW9h009994;
        Fri, 5 May 2023 08:02:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa2qcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MniEs3F7pIHB82mOwdxYK9xCeYEdSMx6JqOsvyC8ctzOfWFPj5rgkIzKVS9+WdaJhzV2K6wb79zxs7NjhJ8Qj8cTaIN17+4yp/fD1DokA9osWsBGIuvTF4RRe972DRKrbP0mT4qCFq4VUL5Es52W7Zca1Vush80Xa1eSFIRlDP0rwa5iWAf9kfxISfwngLD23ajiJ1Ygvnm0q2STuq0fpi8DVaTsx/IZGmjST4xhVQOf32DZibh7UEwNR0DFRGSKimCS8z7u0jl11iuwHb1WghU4Ke2HER6RIY3NqzCWCIN/DIKIbqkTPYezKtk6o7G/A+swxaknyEKmgoG32B3SHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwbSCPq0KSYN1c+4wI6VvlI1PAsKx1lw/yq+vSId+fs=;
 b=NHxWSBHZr186d9wLTLVMJp1cjTFdiE7ugbPYBkCi4d/iOVl1rwCGuU4Em4EozrZS4UuSXkz+LEUfjtYaA2n2/vE2hK5Hbc2a0glw0TtF61Tm/lkEtNDNqMkeT4N/YQpLqd2udlS/Jrn8KFArIRWk08sErq0pugD/AF2QVJpkfKX1j03/4xByfx9B4dKuONYrQi6+LeAnFL+v+jK0hSn1u7vIT9aUw+BmKGmLhWZQBdesAQUsrExxYTqH3Wl7pobusd2JMlLvTYezv4Klpmom5JaM+EfoTX2mVi2zvNQkkF2BqvYkDmrJfNkeL459YPBcHpAf5TiVBGtV61XIxbAvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwbSCPq0KSYN1c+4wI6VvlI1PAsKx1lw/yq+vSId+fs=;
 b=e8YKo3KnBfmt/U2BDmAfqSLZgHwAy72+4y5WuYFn+iy6oYDa4PKFQA4uGKIdkMjeSaS3lPGrAVvzxtkKbEqCdFP6ASx5KfPpwb7a5tlrMa58d2JHfFxg3wKg2ipEwAyO4JeW84/GIpve9WFHIfctIHuJFu1/QVQAdwwdkn4XF5o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:02:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:02:03 +0000
Message-ID: <644fe4aa-cb89-0c14-4c90-cc93bcc6bbc2@oracle.com>
Date:   Fri, 5 May 2023 09:01:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
 <20230503215846.GE3223426@dread.disaster.area>
 <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
 <20230504224033.GJ3223426@dread.disaster.area>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230504224033.GJ3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: dfded6b7-de0e-43b7-0f54-08db4d3f02d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaelUplzaiXoED7ri8bFthTKPw/XTV3saxvmB6Fx+Pa0zNVf2RKcYU05rfAA845sYSKEV4ft/QIW1hxh/dYuQ9C9bh7i97CJTZueNBnfMdw9FjXTf9L5KeE6IfnJy5HxdG+76EwtpxODcHlHbyvTlD5jWJfCnMo+h3qsR5lw4VHgJP17+nqXTMBim0g6ALPYEusqXNwVO0lhMunzepHl8j3oCjvR3Ftf2ztKqd6o1HWJKf2UhD+UAfgA4xF2mJa18DHUPKDtcbKdboGqR8T3TH20CvdlXlF7TQC9otEFwU6Wrv6tseHGivnxPn8Rv0hyOeoHOdEXsUrTSmWURlAqS3GRWILfdhqYYJFlHZkC7OE+KcqawIAUKHUm10H7uplEboZbElFB6RJIN8lr7C62GahAR1RAT2Wmphu2i+nWCy4mRsNxrIrTaB9tedah2Peo7jScMXQFF58F/QJmfRfWeRgvGCUWPg9e3SRNgosZOVXDxNBHXJbXIgr/DXx6bK0MJVsjOMqPWeNYEtyudZLNn9TX+iuMu13R1dZp4eEFJSPeBb0UZCB6tI5DHzZJMHURgaxCMFQiiA355J8tDQmelF3oWYB3otCc1nC0kfABE8O/VsT15EFEMMP1NfBr39uVISxpfcBmuYV5VtNJIC/dJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(31686004)(36916002)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(6486002)(6666004)(316002)(36756003)(31696002)(86362001)(83380400001)(2616005)(107886003)(53546011)(6512007)(6506007)(26005)(8676002)(8936002)(5660300002)(7416002)(2906002)(41300700001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykp6Mi9xMDI0bTdEaFVha01hSG5TM1ZEYjhPMnRyL1FoZEpjSTBQTy9zV3ZB?=
 =?utf-8?B?TEhZRUFiMytZYjhxQjVzRHRnUE9HMVE0TTZaOUJvU1g3aEVtLy9uQzRWbjFN?=
 =?utf-8?B?UnRGa3J2R0xNN2l2YXdlU1hrUHhZcUdSc2RsYVppcG05Y2Q1YTM1ak9jVTVM?=
 =?utf-8?B?cmpmdUhSQXlkV1pPdE9FZ0pPSXBadGpyZ3NLNWFlLzE0Mld2ZWs5WjN5TFFC?=
 =?utf-8?B?WExud0J6cVVjQ2tkV0JmRGJtb3pheGNxUnR4clFzbWNpZDNFc1AzVjZOai9l?=
 =?utf-8?B?VHUxNElHVk0rVGkrTmtNZ3M4RFFya3cxd1VFNTFSMXZTOXY2bENRVGJTZ2Q4?=
 =?utf-8?B?ZlIrNzNqR2xPTHNndHZEZXl0aXgvUVFtZ2kzbU9xTDRzN1RDQmJJL2RDVjJj?=
 =?utf-8?B?ck8wcUxEdW9lUHNnOG5janRmc2lSamJ5eHovMEx1MzNpZ0czNnZZQmdkcDZJ?=
 =?utf-8?B?TG5yY2lWdS8ybWdobURrRWZNT2E3SThsL3N2QnJvUmRsVXF2ZktnM2NtZnBp?=
 =?utf-8?B?bTVFcUJ6V2d4alliM3ZLMEhwcEVvYkszb1NJWEE2WUVnbFBFcnkyUHBDalBO?=
 =?utf-8?B?Rk9IbnFCajhZSEp0bVgzZlVadUNiK211d21Uc2FsN09Fc09vNVVyRkt0SG1Y?=
 =?utf-8?B?UHVodGd0VDNsTzJQS21yMGtzK2Y0OFk3ays2THVHby9LZXRGUDZEK2pjSmUz?=
 =?utf-8?B?L2NRS0xOUlpYMktDaEVmVTBscEJKS3BEYVhRdS8vcU5yQlo4Vk9uSlhXRVZu?=
 =?utf-8?B?RDAyUVdFb0d6Ulc0bnVWL0tKZWt5SFBDK09EU3lkL1FtS0N5QWVUbTE0dWV4?=
 =?utf-8?B?Z1ZUbnh5TmpmdWQ4c1Nuc2NCZUtveFZiK2ZackVzS2R2WHVFTHRHR3RxaGVV?=
 =?utf-8?B?TGVqaXR5QlNhbXYvWjlVTm9vUnBlK3lRaVErU21UMml2S1hUMEJnNHVnT2Z0?=
 =?utf-8?B?ejZCSkdmMnJBVkt1WlRkWUVlb05YZHlNaGpzS24zYVBJa3FKMDVQdDJTdlg4?=
 =?utf-8?B?ejJYYjZ6Y0tHTHcrd1BzQjRxSTNMRHpFM2ZuTVNhL3VKQkd0eTNEV3RDMUFI?=
 =?utf-8?B?UGFzeUtvcUE0M3lGRHpoNHl6M1dvOElVVXVqc2oxdmZGZmViaXltTUdpMmdG?=
 =?utf-8?B?MHFocUwrL3pjVkFxT0piUitZZU5qSG9WVG5lUXNlOEVsRUpkTjlwMjJXTGFU?=
 =?utf-8?B?a0tycFdQeFVDRENaV2dNdmZGNlIxL1FhVlVRanhHU2tyZWNKQ3JreHFiM1hv?=
 =?utf-8?B?UWsrWHl5OEZWTjh1elpYMUVDV25KNGw3TVZjT1VNWEFBdithakdKZzZ2djZ5?=
 =?utf-8?B?Qm43V0RObTk5STJ0dDlyR2ZDT1ZVZWZzTHdEZllUS0owV08wMkhLK2FJNTV6?=
 =?utf-8?B?eUdEYWxSZFZnbVZ5SFNBMEpEZTdXMFh3MmdlalBIalJtUVI1V1lOT2R2ajZO?=
 =?utf-8?B?Z2ZRMTJIVEMwYVJWR05WNnp2bjhQSHZLVEc2bVlwbXIrVDNPaldUVnU2MnBu?=
 =?utf-8?B?VGpxR3JMV1Nsd29IY25VNU5HUXFTZXBOK1g5UGc1Rk12aXM3Z01WN1VEL2lN?=
 =?utf-8?B?VWZXbytDdGZLRmxZSmYvN0JrNTkzUTZGRHNvcklRVjhxV1p2QXNtd2VwaUdo?=
 =?utf-8?B?TVU2V2lnbHphb0x0d20rQ24remY3NTN0bUU5YTl4ZnAyMzBMczNyVFlxaEpw?=
 =?utf-8?B?OUl3dG8vc3lpK1NEUENHR096YzFLS09Yc3I3eWU0VmhYcERHbkpJOEpKVnNj?=
 =?utf-8?B?SjBEN243ZUNJcFdDaXBCNGVjL0Ztc2g1eC8rMkNMditVSHZMeWJVUUEveDdY?=
 =?utf-8?B?Z3hXd3lhWlFVWndmTVc5ZFhFTXVaMmtWU3BjRVAySVRKaE0vRzAydFdxeHhN?=
 =?utf-8?B?OUlaN2tGR2NiM01oazJLdTNHSE43NnU3eTFjN1RrUzhXZGNOWWwrZWZwUzdN?=
 =?utf-8?B?Uzh2STdCMU9WVFNuUk9xbGxpaFR6bU1mU05nSE96K003dGljU2dINW1YSllt?=
 =?utf-8?B?M2E0Tnp6bnlVTG4wQXRUcXhKS2tPWlNUdVFpcDY3bmVaUlJNRnJlT2FraTRD?=
 =?utf-8?B?SXpIdzBBRlFTZk9GWjUxRnVmWnlaaVhxSkRFTlJEUjlaNWJ6alpuV28yamov?=
 =?utf-8?Q?E1T3VJfA9lQY/ApLmObBBheb9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K0wwakkwRTMxQnNFQ2tjNlZHM0YzR1RPUmtCcVdMRU9qMlIwOTIrWVhXUy9M?=
 =?utf-8?B?d2dsM1Qzd09zTjhtQ25DVDYvd0xEZzZ0Z3l4WXRKekhVV1pDRkM4YjFsRVlJ?=
 =?utf-8?B?aXBLWGIvdFEyTDBzQ2tJd3VEWDc4V1h0aEZyZjJBaGZBbWROTUJpaVFrK2Fk?=
 =?utf-8?B?R3VPcXhXeXhhN2Q1N0pOdHFaT3dUaGJyYWRFVXkzMWtzZzVxSS81YlRFNDRa?=
 =?utf-8?B?SXR2R2xEWGcxU0N5dHpSbDk1eHZNdEpwWng5bXk4d0g4dnZQeWdXSGJGZyth?=
 =?utf-8?B?bHlidS9DcGxuUUVmVER0WjFoYW1ZWTVoNSthWkRsQUExTHlJdGtkc0QvMFhl?=
 =?utf-8?B?UTVOUENocTE5UHF3bjJUTGU1Z1gvL1BhVVJPUTdKd0NoVkpHY0VhV1ZGK0Z5?=
 =?utf-8?B?RTNWUldoK0ozUUxwbmRtSkVBanlRcFg0K1ZSS3dFY1lRdERSeTI5Y3Avc3Bp?=
 =?utf-8?B?Vm5tZnFiVlBXdVhQR0VFU1A2cEJDOHdYUHlFV0RiRmhnUnhsS2VsWEhNc2Jy?=
 =?utf-8?B?aU80VDJYNGRBT205S0tWQ0NvWm5Rb3NpUm5xVnFkV2ZxZ1hWTkwvL2czQklH?=
 =?utf-8?B?M2Z4RzlzRlpIR2dzUFFMMy9iT0I4RXZmRUh4Mm8zekZiRnBySnp6SXFLRk5a?=
 =?utf-8?B?U2ZQR0daWjlsTU9DMUJpMXhmNmNRckdGQjRsR01wdjVrM0dIRURJMFdxbVFs?=
 =?utf-8?B?dnkzdmF4YnMxRzJiTElTMDlnOWp6VDRmTmsycEQzQzRrTFZkMlg4U2hkcE5G?=
 =?utf-8?B?VlliVjdnekx0dmZJeFQzVlJOSFQxOFhMTWxKSkM3Q3JXVnpKZnJ1ak1nWVlv?=
 =?utf-8?B?R0Z2RXRvZ0lLaGtwVllEcHR0bjhPK0NCaVorV1JOVXoxK1ZmUU90NnVFYVNU?=
 =?utf-8?B?ekVDSXR5WlRwcDF4SmJ6V2hsVE9OMDJUUERxVDJzREYzcEJESHlCU3MyWHhV?=
 =?utf-8?B?dWRrRlZlMFh0alRWZGR5TEpaOTNDOEN6TzFqcTd0dzExenpMYndocGlaenlt?=
 =?utf-8?B?bnpDZHltcWpXUlg2eEhsL05JL3JlVHl0aEhlby8rbnZ2ZEhYV0R3VTZseVIz?=
 =?utf-8?B?VXEvOUtYN3RIQnN0UWtmNy84YVBtU3dXTmlWVTRUcm1hMXV5NitvV0hHN0lx?=
 =?utf-8?B?alZyL0pqL3kxOEFtdVJkdVBmdnZDQUh5eHVHblJJYllBb3dEbzArcHdFUUlS?=
 =?utf-8?B?YVFkSzhUcG9jQzRoSVRRaXZnOXJKemhiYnlpQmFqY3FGWTdrSGYyTWkwSmRH?=
 =?utf-8?B?VTFqN0xWYkE4OSt2bzRVOENRamZnZTE2dU0zdWtrZERzeStjWWpQYUd0alVL?=
 =?utf-8?B?Zm1TV0RNdlE0bW55YWN4MGYvYk5iTkFyZERVaFlHeGllYUZqY3ZSNS9wL1lD?=
 =?utf-8?B?NVE0ckZjamxYQ25nTFNCU0JtQXZkaFNHZzdzazlMZ0lKN1hjMEY5bjJUajBP?=
 =?utf-8?B?aTUzbVVlTG5BQjRTK0VRZ2QvanprandKcVVlbUJPNnpPZkZqM1BBSExkK1RM?=
 =?utf-8?B?dUZDR3EwNUI1cEFYMTdpNWVEMEFlNGFXOU05V0F4MHhaVGN0UVQxa3hjeEJl?=
 =?utf-8?Q?BiGC5LHBVJH3uWND8KkhfuvV0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfded6b7-de0e-43b7-0f54-08db4d3f02d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:02:03.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO6zG+IG2VnMrXpdKYzz8X3EyNAuEKozNrkn1rCy4TPy0fxQ2OpiuXD3JTTeCTKAjllMEpNp/Cwhog+0RrTYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050069
X-Proofpoint-GUID: B1BI5U_j_aH1MVBVViYEyjNxhwdQ5RQB
X-Proofpoint-ORIG-GUID: B1BI5U_j_aH1MVBVViYEyjNxhwdQ5RQB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 23:40, Dave Chinner wrote:

Hi Dave,

>> No, not yet. Is it normally expected to provide a proposed man page update
>> in parallel? Or somewhat later, when the kernel API change has some
>> appreciable level of agreement?
> Normally we ask for man page updates to be presented at the same
> time, as the man page defines the user interface that is being
> implemented. In this case, we need updates for the pwritev2() man
> page to document RWF_ATOMIC semantics, and the statx() man page to
> document what the variables being exposed mean w.r.t. RWF_ATOMIC.
> 
> The pwritev2() man page is probably the most important one right now
> - it needs to explain the guarantees that RWF_ATOMIC is supposed to
> provide w.r.t. data integrity, IO ordering, persistence, etc.
> Indeed, it will need to explain exactly how this "multi-atomic-unit
> mulit-bio non-atomic RWF_ATOMIC" IO thing can be used safely and
> reliably, especially w.r.t. IO ordering and persistence guarantees
> in the face of crashes and power failures. Not to mention
> documenting error conditions specific to RWF_ATOMIC...
> 
> It's all well and good to have some implementation, but without
> actually defining and documenting the*guarantees*  that RWF_ATOMIC
> provides userspace it is completely useless for application
> developers. And from the perspective of a reviewer, without the
> documentation stating what the infrastructure actually guarantees
> applications, we can't determine if the implementation being
> presented is fit for purpose....

ok, understood. Obviously from any discussion so far there are many 
details which the user needs to know about how to use this interface and 
what to expect.

We'll look to start working on those man page details now.

Thanks,
John
