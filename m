Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7D30B255
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 22:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBAVwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 16:52:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAVwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:52:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Li9kU192501;
        Mon, 1 Feb 2021 21:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+42ztGaUcxlGxOGrYp/4D+e2tRygBSu6p/TrurUZg1c=;
 b=fb1ROMW28l9OI6cHIuWa7/rSTuU4BD25Mxk0krUGZUZKYVm2dxRP6SouiWk1vkvarfot
 hbjWPQZEKZKnROqNeIHaIHjwrXeWwXQfh4L5D7V5emDYIk43BOKFuUMmDsiJPO6/3Cl6
 YPm8iinkPbd+dkeyTfgjWEN2ntLEuNHCfl+FaTN0iGN50WAfbso84+IJg/T2xTqcXAPw
 ZBRWxr0nDLDefaBAbwz0GAAOl6Ff7YW2PfjldSXjZgSv7r1PHrRJ01SdL5wyyuSNQzoj
 JlXe1QKfIRMXwtjSXtLDT7lTMlrKPEXMrjdk7BTWmUlKO+suS88903T+41+iGcz0rBSC 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvqytrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:51:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LiuoK036442;
        Mon, 1 Feb 2021 21:51:54 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by aserp3020.oracle.com with ESMTP id 36dhbx8x5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB1/kPjm0wkI4y3hkG6oG4kifIdIF9ZmZg9CC5qHXtJC0VSCorZmkGpOstPjZ+Y28X/6DOUK3JbPXH3qdYfWJSbsLE8cfKdKv0Jw0TfI5LnthmJeGB7MLIiRl/5BXbmI+wbgPpEkbipQG942aXpJJrkbS26F3tppL+jS1BWTpTqUywZ9oVqWY4+pacoy3v9rKh6XBOISBUmAjpaaTRqtAKErWCw6JW/t5Gzsm7AbG1BU+h7i8pzFXnsf/hhOq5ax0DWKP75veEN9yD9nnKkGf5Z4rP0+qkokG9DopZT4vtpj1Ppq5ky8Z7AUEfycd/vfYSKIz+BmHjAhrXQbku3V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+42ztGaUcxlGxOGrYp/4D+e2tRygBSu6p/TrurUZg1c=;
 b=NaC7naCz/UxJOKRasRG/l9nbS9K7rS9x9+0IAPKQEXHNXIfLROtqLKuY3hK/F1mx1QAS4ThR4KOvTlukDW4Vt6U+ujZrZFhQXSVTxEuc198J6c8enBtvc2981+eZDMVdt/yVN4J7r4wioHlQrkKqjpoFDrz/UUHU4FUj3qMgV5MhxmN/l8/+sPY2AmFpcOZt2a6d7gPJFmdIjoJj7ZMM6TnVpQDkvy5Jxvx8CN2sosl2tq3sCVFmdyzyDghElNjFc1Kx36kdnTmuwDKumru55eBVvER2+2TnL9umzdu150wDD15PAYbI+H2LI2rYH9SN9ICDIhWHgsTyuWAdoLmqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+42ztGaUcxlGxOGrYp/4D+e2tRygBSu6p/TrurUZg1c=;
 b=lriIto1gOqWlFR1FM418bhfnjl+kg8BtUJQ05HAPiICQ7zSM1r0wkMX69yif/z8SjaaYcYzrWih8ih9fjcwS+DSycHpFDZkY6f2rG4+SHWvv3W2z36wRMV45egRZeQgMoVlNQWxfzRKDWOkgiZTpDgI9nQc27H0HMwNLOFjJWrk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB2443.namprd10.prod.outlook.com (2603:10b6:5:b9::26) by
 DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Mon, 1 Feb 2021 21:51:52 +0000
Received: from DM6PR10MB2443.namprd10.prod.outlook.com
 ([fe80::d90d:43c3:fa7f:ffe0]) by DM6PR10MB2443.namprd10.prod.outlook.com
 ([fe80::d90d:43c3:fa7f:ffe0%6]) with mapi id 15.20.3805.025; Mon, 1 Feb 2021
 21:51:52 +0000
Subject: Re: [PATCH v2] vfs: generic_copy_file_checks should return EINVAL
 when source offset is beyond EOF
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20210201204952.74625-1-dai.ngo@oracle.com>
 <20210201211446.GA7187@magnolia>
From:   dai.ngo@oracle.com
Message-ID: <7bc01c35-886b-05d4-3d0c-46cac378a61e@oracle.com>
Date:   Mon, 1 Feb 2021 13:51:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210201211446.GA7187@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To DM6PR10MB2443.namprd10.prod.outlook.com
 (2603:10b6:5:b9::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-174-155.vpn.oracle.com (72.219.112.78) by BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 21:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c07743a0-8dba-421f-b4ae-08d8c6fb95ca
X-MS-TrafficTypeDiagnostic: DS7PR10MB5120:
X-Microsoft-Antispam-PRVS: <DS7PR10MB51207B377DF7520EF0EBB47287B69@DS7PR10MB5120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zsn8zhNQpaLj/idGAH2P6AQQtcVbHRLNqRydO2zPzZ9ecpC04Oag4I6lCvTwS70HOWS+WQsPkl9L0zRBsmFQnG2pOn51Nl2DP4am8IiZDcMtXIvJSXsRrtqqZ/3JTrTpYBMAv/eCTPkQxvAQUFbvNXLfDUD/gyyZvIp7nA1DAIf+TcDrt770WNYrdRJkqT6/QhG9sCQXZL77HyPcduJm3O1drq2Q9RSN5FZb3EDCkccqWnsOeN8dluzATiPXyhQ/qbIueXmuFscmMXrkL+hbsIZvd42I32a1MibQuidKThNO8MYrTjyq6q7JItI4MDT/pi3CWaG4VrAdioEiLo6/JcD6zBahFoGUvXhO8Gx3o7KxDGOBydcYRjVxEGusCPMNnGNOO9040AMLIZ/LdQzLa5tvrogkdCvzBdHTsesb/xBkV0PshMX1yb2ICz6dvbaPlaI3KcAwiJMKPqNQ/rmOwGahWJ6moJj4HO2/KfBfTTu8zEJAxOEBFtGuSUq4A+INJS04mnI820oJmfmtQVLgA159TPH649sPElqyzJlVwK74DukA71jSRvg33V6RwOTSSF6A7WXAdQxulPXAUQwMAkYLaVij2GMdhrtqKLxblNX0+ks7xByUPCmr+6Tdv5XDQ93Bm5URXyUHDtr05dZlN9Unb3c5zp5Y2HB5jtJqq1Dj8bxokExjCAJaCBT/3pe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2443.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(478600001)(36756003)(53546011)(8676002)(83380400001)(9686003)(26005)(6486002)(2906002)(8936002)(4326008)(2616005)(86362001)(186003)(7696005)(16526019)(66556008)(31696002)(31686004)(5660300002)(966005)(316002)(66946007)(6916009)(66476007)(956004)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFVwaDVMTENmZkkweklVc0IyZGR5c2s1MHJlVzQ5aEhTWlY3WTRWbUZXVndu?=
 =?utf-8?B?UVppZkZoa2N2bjBIRjdQL0NYVDFmb050UjZ0RUdJbUNMMCtGZXlaaHZxN0NN?=
 =?utf-8?B?ZEhKSkVOeHo1VytScWlINUJwc0xOdHdUL2hIZWpnZU5GOEtMQytLVVVLL24y?=
 =?utf-8?B?NjlkdlhtejlkU3owZlcrYm85VkJQaS9ZS3VQWC9lMEZYRzZKUjlxbW5ZREd5?=
 =?utf-8?B?Zmg2dXNOWGY3MjJxWnVwMXlVUVVUSngrM0VrMFEvbjdvREFpb2Jld1I3alkr?=
 =?utf-8?B?RVB1eWJrOThteEtOakROU29HU2dmMFM3dTA5L3J0UWJuTVFmeEJDZkxONjFN?=
 =?utf-8?B?K1JXWHZnWWNhdHhONWdyOTZTajZGR2VGUmdPSUdidm1DSWlGKzFmdmh0YklG?=
 =?utf-8?B?K2kyVFdBbmovMEYyMTRpajJMbG5ETW9WWThCVGFXQ2treE5VMzN6TFFhRklN?=
 =?utf-8?B?dHRJaEo1NjM3SXZJbDRIUzdVOUNidmhlMVlhcEVvK1BhRUhJTko3bVZLMlJ1?=
 =?utf-8?B?OXowQkVCalRWTWtRWnljQ2tVbDVqZWxDWXV1VDNzT1dGWStSNFZ5Y0lOcXAr?=
 =?utf-8?B?YTVndjNoOFhmbTZ0OXJjK1h2aGJYKzdQQU5oTGxxampqeFZzWjY1anFudW83?=
 =?utf-8?B?Qm9qZUFMMldBemtyTGVIeDlUK1pXcmxjYTh0ZG1nV05sUEpram44Q3Bxallr?=
 =?utf-8?B?dXZMV080cnJqT2JCMFJjTHA3dlh4SStSRmxzSGxxL3hEWUV4NzhjcDFHN1ZF?=
 =?utf-8?B?bllSR3VYczdGekNLUHNKN0RkZEdZdXIzZno4Q0Y0cUoyTlNIc3p0K1RGdWhi?=
 =?utf-8?B?ZmliUXNHYlJ4MGYvVHQ1YjB4a3lLZjZZTWE3YkFuSld5Rk5PdTZ1T2tvdFJY?=
 =?utf-8?B?N0pRS28rc0pKTS91SDRWeVlEQlFYTkFOckZTd1JMZkNEQ3phQzRtTkVORWQ5?=
 =?utf-8?B?QUlVcHZraTNYNVZyVEQ3Q3BMYXVlWXVIbllndHpNalE3TWE3cFlhdzdUdjhM?=
 =?utf-8?B?RUhnQW00TmphYkQwZXlLOTV5YzJ0T3BKTWg0Vjk3aXplWnJDVmNkeklWWlht?=
 =?utf-8?B?bFBBbS9HSU9nb0p4cVRJTWE4YkUybG5kVFdDQjM2RldUN2piNS8vUWh3QUl1?=
 =?utf-8?B?a0RNN3BqZWJqZ0NlOFB0dktVampaVDFkTWFzeml3MVpKRkFCWmZDaDV5RjM3?=
 =?utf-8?B?cC91b3hDczhtbDR5ajhYZm5Ob0VqNWpLK3ZBSDZWVjhMTTR3cGhiM3BRMk12?=
 =?utf-8?B?UFArUFNGbDhSZ0tKUklyV3E1N1hlRG9ablExcXNsc0FlYmxHZ2ZDeHRDcGxR?=
 =?utf-8?B?NURLeW1PVHJxUjRTeW1qTW1uMWE2a0dYeDVzOFNyZmFQMUZSek9mNTdFaldz?=
 =?utf-8?B?OU9wZXU4Y1ZoWXhMLzZwd0NRREVJenJTTVladkNpUmNjeVZpaVpCbDJUc1h0?=
 =?utf-8?Q?jLn0xvpl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07743a0-8dba-421f-b4ae-08d8c6fb95ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2443.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 21:51:52.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P9nuidZlXqRyLLjIQhkBK6E+1K2TlJxTmub55VEoT+X05UPC8+GOqPkvgcZsyi3wFFnhYoWCBm4lzkujaBijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/1/21 1:14 PM, Darrick J. Wong wrote:
> On Mon, Feb 01, 2021 at 03:49:52PM -0500, Dai Ngo wrote:
>> Fix by returning -EINVAL instead of 0, per man page of copy_file_range,
> Huh?  That's not what the manpage[1] says:
>
> RETURN VALUE
>         Upon successful completion, copy_file_range() will return the
> number of bytes copied between files.  This could be less than the
> length originally requested.  If the file offset of fd_in is at or past
> the end of file, no bytes are copied, and copy_file_range() returns
> zero.

In the ERROR section:

ERROR
	EINVAL Requested range extends beyond the end of the source file; or the flags argument is not 0.

-Dai

>
> --D
>
> [1] https://urldefense.com/v3/__https://man7.org/linux/man-pages/man2/copy_file_range.2.html*RETURN_VALUE__;Iw!!GqivPVa7Brio!N8XGLyK9dUTWOYWmb3NCuq-9kL-tX8OGcq-sV7M53ub5KMgr7e93a2B8eUryKw$
>
>> when the requested range extends beyond the end of the source file.
>> Problem was discovered by subtest inter11 of nfstest_ssc.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/read_write.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 75f764b43418..438c00910716 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1445,7 +1445,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>>   	/* Shorten the copy to EOF */
>>   	size_in = i_size_read(inode_in);
>>   	if (pos_in >= size_in)
>> -		count = 0;
>> +		count = -EINVAL;
>>   	else
>>   		count = min(count, size_in - (uint64_t)pos_in);
>>   
>> -- 
>> 2.9.5
>>
