Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0738F176
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhEXQ0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 12:26:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhEXQ0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 12:26:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OGGGs1006835;
        Mon, 24 May 2021 16:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nBmGwkuOw8vDUAy2XoVaHynhqclkioZwVDyehE/fp8U=;
 b=Zc+FvzBFrphWSjL1s/PNljv5eDvdOYfiQNZEwrQCJgaKSqcpGewQPwzzHtlxZS3ap3ki
 sB5pM02x95w0tUr9EJc4E8x5g1SOrkI4wzkkYNgR+RcQHfeznbsqgiKlivZo4bFLB1z9
 PHqE5HesHdoyvHxaM6GbBLa0arqgzu66N2AACKT/JQUv/tg4gRTa9xSIyzibJ0bi8oHG
 +k5JCegy343WGphMX2p4NvLRIvINSjRbCrImzP5QA9zzR84oklwAyRaIv3DeV0kBfXoM
 PRP1Y38D+2sq1Nml9FXLhjxVqttydIbnnfxEOKRIgVyjJwlU/9vFokAOytlO99pvnRMp Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38pswnbjdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 16:24:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OGEiOc111407;
        Mon, 24 May 2021 16:24:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 38reh7eqk6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 16:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvnyLMkuuz25MUcFKKMvTVVUdLEo4bW8ZdxGMz7pMZnyi1a+RunfCnS6ERM1fGa08B149vWanCr1QpydChPyd+FaXAFRmCi/ygWHLl+ZvLQKEhAdpiVSC7+L2E0RgT18hZH3el++y1PrcKi1CE7ZZagEKN3RWFpQK3bec7y9DcSiSD1q+U/VsSnA9326sZUhTQJiFblY9qvX3t+slCxOH50ALdJx68/WNCjPDnQlS4ulQqdCrIqJs5iIkdfsuZgBUCXUeWUEftbi/znmeT2MtUvjsFaBKQOLe0paY+RPoCEkKmfUcUaIijJDpC/kI8sWA5zt7x7jPYiLg6mnzNikFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBmGwkuOw8vDUAy2XoVaHynhqclkioZwVDyehE/fp8U=;
 b=AwVvaBSN4MLW4Zo3JD41MAwIW8Hw3Y40wURSNOn9rieoUr4ABA/d2z9UZtY7gVIC+JPobf6QDjE6u1sSx43x4OEVqQepnFFalNREp0cRycuYwIKJec2QDWpkEFElTX24OT3Bylgsqg2mBOQTeemL1paiIVgv5miiQmANFTpgEG6UvZmjnys/hgeCbr9d3RevOLNNVGvvqhoVTsB8+lNheeOd3H0L5/EXgZURB3otEBPw75Zpd1AcyS3Hv1wsjIwwd5IFQq04HW1bg4/++QItV9KEBFsMEAhA0RcdO4ryxlGkFRXjHg0ADY/vK8v50NMRwaZl1qE1WT9oVAXS+3Laaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBmGwkuOw8vDUAy2XoVaHynhqclkioZwVDyehE/fp8U=;
 b=u6yCRY32BxUo+sZ6PrOmKEj/7UwmBqDdD0TW83aEkVH8XPqKjrSeGD+LwR6FZ54UGyS4etdaFFX8iV0JU1AuzmRpC/c7V6vWQjzOEmcU50AMcK4fx4TlhjTN6YjUHphucovUyATs3ByuqUt3qne1KrdJxBu2C4PUwYnXoq+Bkxk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2469.namprd10.prod.outlook.com (2603:10b6:a02:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 16:24:24 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 16:24:24 +0000
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <35a1d32b-b8d7-ea9b-d28c-6b4fd837605d@linux.alibaba.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <8aa90f5d-e4db-5107-1d3c-383294871196@oracle.com>
Date:   Mon, 24 May 2021 09:23:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <35a1d32b-b8d7-ea9b-d28c-6b4fd837605d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:180::32) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-138-166.vpn.oracle.com (73.231.9.254) by BY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:180::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Mon, 24 May 2021 16:24:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f5a440-a7cf-47d3-c2ac-08d91ed064c9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB24699BB3B56B5D995E796A7DE8269@BYAPR10MB2469.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgR/zHn3fadPpD+bY8HRCUYMzrWiPD5BwnJm9u8ELP0iuuVfPpnFZCw6yXzHxxCljxBQdAyqR/uneZ9d3jBu995dgtrKn++dXxB9PZEL3yhsTTfhx/82sDQZ06GXhUlhO0ucGH0deUdKTRWuhnDdiVa5WTN0yNu/DnXQNhyNbn6kmI5BxKebaxLFzj4r4Ac2JP8MtIyaZzPn5UcgtEqVFwZkEwRJC0qtDkk7QDOEM3+nY6bbjM3Lhm5SEBFdtnOx6kvgQpGgV7HurpTnKgU1B22JRS9TfJpplCL2dT3oXemGEEAXItgdU+A2ezHkUgWR5VcD/rpBtg+0KO/myxR/xcQGXMsLjXpfSVzV5C4AmGDEP7j6bE+wo89Nsg+DOQRLBhRwI+TEWHMRBQNB4UsHmltOQY735KeHSmuoKCBYWa3VRbWX0DsbTHoZ/VcASQ+xNMUPafI+Yw64Dxa6BAeotCoOTTW4nQ+RhLQT9wiNN8MCXDZtSXGH7mtLXTmf1g8OT3F1HHtQypSB8dCOYEl4+NMPNmuXUfuOulb7F8VNPCCd5BmMs8oYzkBuxa9s7zhGRwMB2oL1+I9RcHfUMgIs4mp1n5Q/euBcV33Efn+fxi5v93qVOXAFm1WaZXvQ1KYeKjM1BSXYIX5u5sjJcLrRUCndfxzzTBqIeEqAHIjywFRxPsOFOBb1HtdkkgqQiy3iQaM610HrmIBj7o381tPHCPT6jP82ZdoxNMWq4Bd5L2U4DJBGetY2PyPIVKE09iwbGceJM0u2zsQLH5Vc+/r7/siBAmQNH+YXIeHaEz8qQ+9Jjgd2TnhMR8tgCIs3WrbO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(2906002)(316002)(83380400001)(7696005)(31686004)(53546011)(38100700002)(36756003)(956004)(2616005)(66946007)(44832011)(26005)(66556008)(66476007)(16526019)(966005)(4326008)(186003)(6666004)(5660300002)(8676002)(478600001)(31696002)(6486002)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SlFrTU9uWnRlRU1jdlJxOGpIU0tTSXhraTZZSWdsamFmWEw5Y0hXN3RLcmlH?=
 =?utf-8?B?S01Cait5d2p2M1R4RUJWMDdDWWRXbWlsei9kK2xTbno3MjI1aGFsd093N0cv?=
 =?utf-8?B?ME9oMDNldlhvdWZwSWwwV2VxSWFtbGJPZVB6Q3AzVnFCVmZmWmk2VFJ4V1pF?=
 =?utf-8?B?UFg3bDhXTHpvRnkwdmhvL1N2Z3dzaVpCR0lYdmFqVlpMN2NTWUpFOGVhemhI?=
 =?utf-8?B?NTdJeEZYZFpjSUpMejdCSWMyMHlXeXRqSFhJUWJhaEtPZDBQOUFoeFV5UFE4?=
 =?utf-8?B?NW43VmcwazRnaE9WR0QyeUxmMndaR1dla3REbU56NHFKdTVIVkV5cTUxOFRx?=
 =?utf-8?B?WGlYNjNsS3BoR3lnOHFqSVMvK0ZQMGlBL3JOb05HVTdITkNQdzdhU0pHMGk1?=
 =?utf-8?B?WHE1dVhjNDQ2aFh4SnpSMmx0VXBCVmZTNWZnODlYbEpwTWFFTzNQT3lUR2x0?=
 =?utf-8?B?aDJWTmpmNG9WWU9xUFlENU9KcjFGMmRTUVpRUXVwa21lUDdjQVdTeWtIZGhm?=
 =?utf-8?B?K2xkVWNEK25HbVh6Nmp0TUk1MXFEVEhOaTN1aEZPZCsvWjU4WmJLRDNKejNl?=
 =?utf-8?B?ZG1NZWliQ21ScjFkcXNQbndmMnFzemlvQzEvZXVzcVZ3a1hrcTBibWxtSmdY?=
 =?utf-8?B?YkZUM2lqc1I1L2wzaktLR1A2Tk5FWFo5ekJpMm1lbU9ub1dKSnJFT0pvYjRn?=
 =?utf-8?B?QlJRTGp6cFBvMTBPU295dStEeE1jWUtESVZWYTc5YWp0L2V2WVN0Zm5KbUs0?=
 =?utf-8?B?OXB0NWhXbjNxRGhWSWZIWHVuTHBYM1lIWHBYeGcvWUtZRFhQUUZsdEgranR3?=
 =?utf-8?B?NDZyTDlHN2s0bkYybzgxYW5id1lGOXBnYjNWclR4cTlwV0dxRWVkWTJuTmor?=
 =?utf-8?B?dXNvSlBSWDMvZmhwL0xJWWoyc3M1Tmx4RGpDMjZYSFZhci9KVFBVNEVWcC96?=
 =?utf-8?B?a3VVUS80U2RXdWZwamNnM3h6VmJJeWNBQ0NIc1VVU3I0c0I1RmVrQlVHQnpp?=
 =?utf-8?B?d01KT1hCazFpb3VmSTdDdGJsYzg4ZitzcVQ0TDBqOUYwYmZDcGk5dnlseGNh?=
 =?utf-8?B?R3JaZVA5aXprV213WnhiQ09rc1BOcjJLV3NoOFNKNkJ6bVZldWVoczdrRE1r?=
 =?utf-8?B?akFsejA1eVhQMjB4Q3VPbnpSSDBFaUI5WlRIZU1rSzE1Z0hUQVEvWVY4UDZk?=
 =?utf-8?B?TmtMVDRQL04wVkg2b29uTVIvT0ZtdUsyRVZ5SUp3dlhJV0JJcmx4ZFZLOEZk?=
 =?utf-8?B?ZkpJUnNmZW4yeDFlYXc0R0FTUFhqZFBFWWkwTXJQVkhpTmVnRUF0YWsvWU1O?=
 =?utf-8?B?WWNmNnJZYzhVM1VYVmlnZWVBZ2d5ZUJWV2EvSEZLWG1ISXBINCtscXNRejhE?=
 =?utf-8?B?WnB3czdweVRscy9aVHVjbjJndHV1UkhUcVg4SWR4M2hJZG5oOG54WFQxTXFz?=
 =?utf-8?B?OWZsODQ5dlFPVmtvWE1MVXd3Z1d1bVRaZlQ5MitxTkhlVk5sUWJDSFIyR0pF?=
 =?utf-8?B?aFF3bUVCamtTcjZ0eWUrdE9KTzlRWEMrS3lGTlRrdWhOWnA4M0FITlFOWHN4?=
 =?utf-8?B?RzFFM0xsM25vVUlSSFo3Mmx3Tm1VaTZjd3pxZzhXd3pzRmJxRGZGbW9nbFRa?=
 =?utf-8?B?cmw2dGNUdWRGQUl6TTF3NjI3dFhDN013Q2NLN1lIcVRValBKVnJQV3BScUtZ?=
 =?utf-8?B?OTlncG1ldDNNUHBRcnhYY1RnUkZicm5yVVVYaWZvM2JlZXBmMGZ2QjArejBO?=
 =?utf-8?Q?nQRQTKk568/IPpRkFMsMcOxXyTY+UsrtZNvRmNa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f5a440-a7cf-47d3-c2ac-08d91ed064c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 16:24:24.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfCLUJX/gvCuNz72WRts6yFWPGdTX4kWlQWcDXomelVX+lPRDZrpe7hZECTdVOzjNjS4kKqKqzK+RpanyVj6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2469
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240097
X-Proofpoint-GUID: mQ7d4weTXmA5F9ZTRmD_EtJtoQAfxkpL
X-Proofpoint-ORIG-GUID: mQ7d4weTXmA5F9ZTRmD_EtJtoQAfxkpL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240097
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That will not work, buffer write zero first, then update i_size, in 
between writeback could be kicked in and clear those dirty buffers 
because they were out of i_size. Beside that, OCFS2_IOC_RESVSP64 was 
never doing right job, it didn't take care eof blocks in the last 
cluster, that made even a simple fallocate to extend file size could 
cause corruption. This patch fixed both issues.

Thanks,

Junxiao.

On 5/23/21 4:52 AM, Joseph Qi wrote:
> Hi Junxiao,
> If change_size is true (!FALLOC_FL_KEEP_SIZE), it will update isize
> in __ocfs2_change_file_space(). Why do we have to zeroout first?
>
> Thanks,
> Joseph
>
> On 5/22/21 7:36 AM, Junxiao Bi wrote:
>> When fallocate punches holes out of inode size, if original isize is in
>> the middle of last cluster, then the part from isize to the end of the
>> cluster will be zeroed with buffer write, at that time isize is not
>> yet updated to match the new size, if writeback is kicked in, it will
>> invoke ocfs2_writepage()->block_write_full_page() where the pages out
>> of inode size will be dropped. That will cause file corruption. Fix
>> this by zero out eof blocks when extending the inode size.
>>
>> Running the following command with qemu-image 4.2.1 can get a corrupted
>> coverted image file easily.
>>
>>      qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>>               -O qcow2 -o compat=1.1 $qcow_image.conv
>>
>> The usage of fallocate in qemu is like this, it first punches holes out of
>> inode size, then extend the inode size.
>>
>>      fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>>      fallocate(11, 0, 2276196352, 65536) = 0
>>
>> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
>>
>> Cc: <stable@vger.kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>
>> Changes in v2:
>> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
>>
>>   fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>> index f17c3d33fb18..17469fc7b20e 100644
>> --- a/fs/ocfs2/file.c
>> +++ b/fs/ocfs2/file.c
>> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>>   	return ret;
>>   }
>>   
>> +/*
>> + * zero out partial blocks of one cluster.
>> + *
>> + * start: file offset where zero starts, will be made upper block aligned.
>> + * len: it will be trimmed to the end of current cluster if "start + len"
>> + *      is bigger than it.
>> + */
>> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
>> +					u64 start, u64 len)
>> +{
>> +	int ret;
>> +	u64 start_block, end_block, nr_blocks;
>> +	u64 p_block, offset;
>> +	u32 cluster, p_cluster, nr_clusters;
>> +	struct super_block *sb = inode->i_sb;
>> +	u64 end = ocfs2_align_bytes_to_clusters(sb, start);
>> +
>> +	if (start + len < end)
>> +		end = start + len;
>> +
>> +	start_block = ocfs2_blocks_for_bytes(sb, start);
>> +	end_block = ocfs2_blocks_for_bytes(sb, end);
>> +	nr_blocks = end_block - start_block;
>> +	if (!nr_blocks)
>> +		return 0;
>> +
>> +	cluster = ocfs2_bytes_to_clusters(sb, start);
>> +	ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
>> +				&nr_clusters, NULL);
>> +	if (ret)
>> +		return ret;
>> +	if (!p_cluster)
>> +		return 0;
>> +
>> +	offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
>> +	p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
>> +	return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
>> +}
>> +
>>   /*
>>    * Parts of this function taken from xfs_change_file_space()
>>    */
>> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   {
>>   	int ret;
>>   	s64 llen;
>> -	loff_t size;
>> +	loff_t size, orig_isize;
>>   	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>>   	struct buffer_head *di_bh = NULL;
>>   	handle_t *handle;
>> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   		goto out_inode_unlock;
>>   	}
>>   
>> +	orig_isize = i_size_read(inode);
>>   	switch (sr->l_whence) {
>>   	case 0: /*SEEK_SET*/
>>   		break;
>> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   		sr->l_start += f_pos;
>>   		break;
>>   	case 2: /*SEEK_END*/
>> -		sr->l_start += i_size_read(inode);
>> +		sr->l_start += orig_isize;
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>   	default:
>>   		ret = -EINVAL;
>>   	}
>> +
>> +	/* zeroout eof blocks in the cluster. */
>> +	if (!ret && change_size && orig_isize < size)
>> +		ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>> +					size - orig_isize);
>>   	up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>   	if (ret) {
>>   		mlog_errno(ret);
>>
