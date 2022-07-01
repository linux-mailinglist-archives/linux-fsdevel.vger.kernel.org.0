Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC756376B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiGAQJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGAQJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:09:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D81CB0F;
        Fri,  1 Jul 2022 09:09:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261G3IjQ015624;
        Fri, 1 Jul 2022 16:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lcw6uFtgutn2hipDXku93Tm04n00ZKGLk+E/mteJcLg=;
 b=in79txwZmR1va8spLsCk68Xlr+QzgTSkJ0/CRtjoeLDF3HrdBqD5QOPtF1Lv1vV3Ux3P
 ap/OeTLmiq9v2KRGN04UAuHwY3n6zZAtgTdHqe83OXTOubyYrUd0F/fRcHhQVeatnfyb
 w0moNi1NAw6OxEqBJ/6ioBMk7yl9rHxeZ0U3q2L0DlQ1Fth/dUHT3wMCtFIVdSXrPh0+
 5x3K6TDdPtf3ofzi2gYZOboAxBYYPpIOmAIPMcA6vl+FHOLV8Mdwcxa71D/vMek2kagR
 HZlzEKem4Mmye9OtHvfvIYUvITAwNthVHwzhcUs40bzSKRMWNFRb6Z3W40tuZKW8FVWs Rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysqee0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:08:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261G6UB1035249;
        Fri, 1 Jul 2022 16:08:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt52kut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdU2AwLlY/bdgPhCEHUhVAHX57jvNOeEX3dLv7xfdQI22M3inH7x8g9f6nWvHZje3Am9vN4O2xRreQSB7fVYkCBemZIrhruDxJ12edYbnpyk0FCryTjRfN5mr/6+nE1WL+s2MvJ5nKmlzZOoZEqilJQKpRzJ1Cc/Xb0XCN8tXGmHCcH8qT6o1x3N2Dd8m8kVnSK57Dy0AHQapkTcCfiNLNCiFpjhgwRV28evIx3PtTJuRkTTRGBFZnswOy2NyC7h6e9QMjQ3iL3Wjx0Hsqb+AvoB79XIm5Jt/ipGDCjnHLnQa7zvFQzfxHdp9cZI/Jqe8ANMj4DPVeYGmDqC/AGd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcw6uFtgutn2hipDXku93Tm04n00ZKGLk+E/mteJcLg=;
 b=kzJB8eDDjzPFAm6X70c7uNGat74i5OScOYg/KUIDQWLonqKM8dgrFS0W7I6uP4/J/XG4JIgg2pP5L6cj6s9AQ5ek+0q8C51HflHWlgeRC4/2tECL5mW/SB/RPbjLpD3JxpC6r5Nz3r5xZgACZCLERf4MKIqA13/G/pw6hPYM6VLS3io+yQ2VC+w7sdhnZT8MJz1z2jWB5AOudBpKN+gGPyEO2MPzD2kxsFGUG0RhKafqGQaY097o0zTjSLThuXcsrlvra/2WBmrX0DIZXzzGze2O5MdZZBkG3yZpAmzNmFv2fQEa8LkkP82UT6EB4P1N6SYEsNHQWjZl26yXTgooBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcw6uFtgutn2hipDXku93Tm04n00ZKGLk+E/mteJcLg=;
 b=r6IYPP6isTBwko4GSIHH+bjiIJ5YXvhVqFqSyxUYlkHyVuB11d1cC5WiNWT0AhL+Px933/nlLft3UlYGeibDPEbq0okm6gecUnzpeK3foJqd4tICMi9vFLtUN2Br6pGGfTVEAw64mK5TkBi7CvPMYdameKU3skapRHKm9eWWUxY=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 16:08:46 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Fri, 1 Jul 2022
 16:08:46 +0000
Message-ID: <5312a278-b6c2-4778-97c8-3c8628d9ee38@oracle.com>
Date:   Fri, 1 Jul 2022 10:08:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/9] mm: Add msharefs filesystem
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <de5566e71e038d95342d00364c6760c7078cb091.1656531090.git.khalid.aziz@oracle.com>
 <Yr4qY32eHzJy5vvw@ZenIV>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4qY32eHzJy5vvw@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77100e97-dcf0-4adb-7ebb-08da5b7bf9d5
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR5cRU80pxhJ/CdU+4IDZPAQUuJwD929p6rFasIpn3iif+u31R/ILH70U0fOeXVibq2xTyp6aRdeshxrHCXrfE5fT2du+OeFj1Pzfpq5LYbaPgjXjvPrVN6oJhMqN/IjeP3/pXK5WkW7V3lhImjYYZVnhUkMIcb2E0wBB4O4uWkUEXrVWeVErsxNmHnq+ePlAhE65jTPehJ7mFTPWwaGDzhwlmn2mB7tUN5YwAgH/4hf3vs+oyFKzHfdh7PumegOfPHe8hspIgg+bEep+Vk7+F+pHyWnhpOBJHt2q6ABaLFuMpIvT8ZzKtQyI8kYafTFao3bFRwqjHpH0otFIiTeObOJZD8FW9YTJDb+8gFiTG0t5njMMLqz1usb9qeogCHTIkbUXP2dhk1lk9CH3Z8oZgxsvrglQruNrUGls92qSQNSgcrKn/HwMgC3JCwu4zur4JMA1AQqO0HDb0CcywvwZo7KfURNzJC/H+TH5Q0moVxmK0/s4JH4ZiT/VuwDEyGZPKvhDAKXXYPfUZNcYQSvBHBoozC7VV9LCO5ZU4y04oQaaNMjBVxW8iVu05eQUzfL3KQYjsmiKb+KHPWRjGreWUFfap0NBRHU1us3zR7wAoTs/L0Ru/1bf3OpWVo7hUb+Q8QLK0at5Jkrg1UKERmaZtRijaOfN0uc9V+68Q9MSCmQHklOXcrR1epRBGPcFANdtJslKVsyGMAq4q4gGPbwV2KHt/J4OTbH1pIvOqrxfHZdILd6td0MYL+05pkkNhgU6VOw6yN+caaxE/fhDLo0mBET+IrhMgQIukOkjpHcRxNhXD/QoLsz6pGyVZ0abIHzOvVUD3/GWUzCbv8k+Ur2aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(6512007)(86362001)(2616005)(4744005)(44832011)(5660300002)(8936002)(53546011)(6506007)(6666004)(6486002)(31696002)(186003)(478600001)(2906002)(41300700001)(7416002)(36756003)(31686004)(38100700002)(66946007)(8676002)(316002)(66476007)(66556008)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRqNjZnaUJrYkM5SHVnUE1kc1NXMzJSM2t6SmEyTTFtem1jRjFJLyszVGJi?=
 =?utf-8?B?YVRKMENCOGV2M2NUSEdTbnEveXBMN0NhaEZJSUJvcm14N2JHR0xkaDI0dUxo?=
 =?utf-8?B?a05jQ016dUc1Y0poS1AxZzVZbkUzOUI0NUVadTlXS2VpZkNla2VuS3ZPOExa?=
 =?utf-8?B?aHhvd2Jtdjd0MHZ5WWNFalg5bWQvT1NUWi9tYVpxUWJGMmdTeFNmRmI2Ujk0?=
 =?utf-8?B?RFRSZmtqTHFDdVVvSFkwOElUVy9mUkhBQnFqV3JoZ1JrbFVXR3FORmNhdUt1?=
 =?utf-8?B?T2wxcFc5SXRUNG42VHJyRG9CQkgvOHRQSmUycVRXbGJJcEZKb1NJUWdhcWlZ?=
 =?utf-8?B?aTdKRmV0d2J2MVpUWHlheVZYZTlKdEhqalJDbnB3RWZwZXZYTVlsN3AxRGVi?=
 =?utf-8?B?ZFJwVStXRFdYT3o2YjdXalQ0N3grZE1ZbXdxVGw2YTY4RlRSVEd1Q1JKb0NF?=
 =?utf-8?B?Wk1yZVlZUWFHKzV5ZVFtN2RTOFF6L0VCSjB2MDRQZGFhRlltSTN1OVJYQ1Zn?=
 =?utf-8?B?L0pGT3UzK2dScnBqMFlWSDlmaUN2Y2RjU3lrUjJNVVpONmplaytkRWhMOHNR?=
 =?utf-8?B?dlNlcUJzeUp4VFFaWGZNTEVBL3N6Q0lZOEVWRDUzUFZMMU5vMHpuRE5FNnZT?=
 =?utf-8?B?WFhFNGZJSzNYTXE2YkdxYkFKR2F4N01sWGZja3FMbWxmNnpMY3BoNS8xZ1R3?=
 =?utf-8?B?ckoyMExHSFJ1N1h2dzlxTmZGYTV2blp0NUF2NmR5NVVKQXRNSWdJSmpKWWxH?=
 =?utf-8?B?ZGIvRFpTYVVUd1ZJYlMwVFhPbDAwc2ZUcHF2SWtwK3pKTFl1RWEyRTNhVnFE?=
 =?utf-8?B?ZkYzMGY4bmg0V0NSZVRSQjU1QUM0d29VS2lORWJ1TWsvWE5ZQ1QvWUJBOEY3?=
 =?utf-8?B?ZzdIWUlXajdsVXA1VUpYYWIrN09zNEhzaWJ1ZExFZFZ2VFNjR3hBVUpwQlNW?=
 =?utf-8?B?azRDSDIwdXhCUEl0eVpIWTdGMkZxZmtCUDZKRXBHZFFLbWMyVEN4d3dBVzBF?=
 =?utf-8?B?YXo2cDRTRTlVU01Oc0NMZ0VnVVRMczZ5OEI2RjFpNmZUMXMxcHZKSzhvVmZr?=
 =?utf-8?B?Vy9mSkpITWtTdWhWU1Y0NVhQdE16L2xTdmhudUpXRmNKOFNsSzY4blkxM3hR?=
 =?utf-8?B?OVRpdmsrMVltT3JpeWZKeWZMQTIzNGd6RUc2MFdRZnErc3c3SEhScFRSekE5?=
 =?utf-8?B?Y1NMNGVLcEh0N0w1VDJYMUF0S0NlUVVvNTh6V0Ira0VRY0lHK2cwRDhEL1Ra?=
 =?utf-8?B?WVRDaFZqU29ZanhJSWpzNkhMYXlqS1BTcWR3ODA4TnZraFNxM05uYVdVRyty?=
 =?utf-8?B?M3RKdUJJb013bzEyWG5QL0ZFd0JQQmZUbWJsVjhWZkRSckVyMFQxRjVnRmRB?=
 =?utf-8?B?UjJ1VVp1dFB2ZnN3R0N1ekJrbEtHMVBXNDlGN0EzcHl6VnI0SDMyVnl0ZEI0?=
 =?utf-8?B?akwyditTcUNKN0J0REpac3JnM1pKdjVObzFyOFVCc3BLUXhVVlhpalU3Q2wy?=
 =?utf-8?B?dDVPQ2ZrZmNibGt0MjMrYkdsYmJpMzlrbEUwZFo3ZXUvZ3ZkUHVvenYrV3Bs?=
 =?utf-8?B?STB0bHgxME5QOGpNTW50MzhBVS9rNU1zVFBvcUY3TVdzYjhsTXFTb2lRZDln?=
 =?utf-8?B?Sng4THJTMnRqQmc4OHlrSmFQejNzb2d5WjVrSDVHSGM4RmsrdW04bnc4MFFj?=
 =?utf-8?B?UnkxY3RBcEtJUXQ1TGhLSC9ONlNMRmo4MWZaU2ROU3lvakZqRG9aQ1dXeE8v?=
 =?utf-8?B?ZEI0MTBVQStaa3NSbTB2T3pQN3NmczkxRnk1TG9lUEZUU1B5SVhLNE1mWjVZ?=
 =?utf-8?B?REx6TWZCM3R2UmlFdmxXMCtRRWZTTktuYnovVCtCSkc3VVlhM2NiVWNzOUZk?=
 =?utf-8?B?WjQxaXBJMFRPMnhoSkVCaHV4L2hPY0pwRDB4ZVJPYUs5d2RqbnhIME9IZHpn?=
 =?utf-8?B?bTNKdWhKcTFlR0JaWFBiZGoxNmR5M0tuT0hSaDFqVjhWdVgxWHJBTDAyWUda?=
 =?utf-8?B?QkpIUmN0K09VRHVzZkpDeTNwZENzQm1RbUFoMzFYN0VCbkZiUi9ZY1lOdVdw?=
 =?utf-8?B?bzA0UUpndWJSUHkxQlB0RC8yNithdExEKy9BaldXblp2T2dqRnk1K1FlVk1K?=
 =?utf-8?Q?3Vl9oZN1P/2CmSfNRmGMkuHSf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77100e97-dcf0-4adb-7ebb-08da5b7bf9d5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 16:08:45.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5NerDvstpXe5Ln1VwCFiqCCR5xqdH/uA0FvyAm2i6KtrTtJ816hZCWub0pvdvpQm1c/0SgqOpLA241cNwuE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_08:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=746 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010064
X-Proofpoint-ORIG-GUID: 7rl-QwhHTWJ1FQtmvyKuJ5kG3U0wh0Gy
X-Proofpoint-GUID: 7rl-QwhHTWJ1FQtmvyKuJ5kG3U0wh0Gy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 16:57, Al Viro wrote:
> On Wed, Jun 29, 2022 at 04:53:52PM -0600, Khalid Aziz wrote:
>> +static int
>> +msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>> +{
>> +	unsigned long hash = init_name_hash(dentry);
>> +	const unsigned char *s = qstr->name;
>> +	unsigned int len = qstr->len;
>> +
>> +	while (len--)
>> +		hash = partial_name_hash(*s++, hash);
>> +	qstr->hash = end_name_hash(hash);
>> +	return 0;
>> +}
> 
> What do you need that for and how is it different from letting it
> use full_name_hash() (which is what it will do if you leave
> dentry_operations->d_hash equal to NULL)?

I don't have a specific reason to use msharefs_d_hash(). If full_name_hash() can work, I don't mind reducing amount of 
code in my patch. I will take a look at it.

Thanks,
Khalid
