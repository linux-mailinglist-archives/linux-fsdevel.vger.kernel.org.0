Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1887660F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 03:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjG1BGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 21:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjG1BGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:06:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0930DE;
        Thu, 27 Jul 2023 18:06:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFO8m6028977;
        Fri, 28 Jul 2023 01:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7bGFJajdP+3CLSDe71KBXqyaN6UuF1naT7Z0S8chF+4=;
 b=f0wG3dgoButCp6ApUimLunp96uVV84tnwRSbi12IDxbxzgTEjBp37Wf0TF7kxuESFjfj
 Jqmw/MJfKFVsao/qwQlJP9TllXIoOO4HvdfBNuBbFLtRRWWH5gWe2Q7mw1EEiZI8Zs/K
 70ueamQwM6vR2RAfjNQuEaL5Ckc+jLVGv62194YEyNDT/TBRL31o30YFA9i6LLyqHO2H
 PuDIrWOc4IXfCwWhfMdCQ7Dh5qvFAOcZ2YAC2ySOhjp+ReDVVsdmN7HnX0PDuiBaPcEY
 EhpqjUAK+CCCOb+IMXxNimHcwhabZtQgXUF55gwMD+VAmDhS6bFZRYrqBkvHrUFxh2gO mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he2w63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 01:06:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RN850a011839;
        Fri, 28 Jul 2023 01:06:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8mara-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 01:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNlT+3rMLtWs65EiwFetBGA9lxdH5XaIaQK11sGSLAmlgXh1JMhbRJhwQXyV/nf47cxavMiuQcFcMou3HTWPkmGNXfJZ3Hrs27e7eGEm6dgZDVbJ+6QXoLJkE/eGfA4WOiQZFJHdqbCWD3hQheMuzObNY63O1hx1W/sD/MN44i3xp4+LGC126eQ2XKW2+gU4FPJH8Og5V49ld8efUrodiQz2Qs6wJ0G1A1Z8sg3yimDNSW+K2QpE3xXLQl2175YNGKFTgjNMh5hxecTl17P67oaBwFQH6ROQaQZhz0bcXBc/dV0XCZiQ1VwrBLkmVnAWAfoaIBzHxQ5T2y7/LmUTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bGFJajdP+3CLSDe71KBXqyaN6UuF1naT7Z0S8chF+4=;
 b=MWgSitwCJWqVUDvrAsKeKLvnO8olcQCZj8AGMUivJrILI8wPR74vlI842EKZygheAHZogGvNyyNUiIYeAgQigQFFLl/Ob+G5X2F0NOKwx1LLWMx5DfkuyLFzXIeNOqtjClScnlahGldGVYCEdvg1ubkCI1iRs69jLHJRfMGt9W4TrdJzCv+Hf3zpO0dB8KJMMdqKHx0wBi5RiS/eSVDSbzdsF36nQgdXg4Mq1HQgyyXAeuS7Ao58FXzHNHDiA/Ug3FJXA/y5ZBseswy7N7jsqyHjxH4AnnYW0GgsQyyq5QW3gg1ghFAJ8HLbppnio7b9OQ7iPEO/ZhPXqgYNZmHqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bGFJajdP+3CLSDe71KBXqyaN6UuF1naT7Z0S8chF+4=;
 b=mZv2CjRqhSNa5zZ8i33uHj+Na5W77SFm3PRXMn6gY2yI8RrGrAzv1npi7pJHXlLMEytk33EpJXvJGMDwv2vnJoZ6sRDDTqGYRjY7TcAGuxojQv0HkJy9kZJLeQpcppdC0/hmv1DgoIH/jEfz6uRElRYLfwUrEM23bt/8tISD3mc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by IA1PR10MB7262.namprd10.prod.outlook.com (2603:10b6:208:3f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Fri, 28 Jul
 2023 01:06:20 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:06:20 +0000
Message-ID: <120330e2-2b37-1d0c-de60-18ae66de573f@oracle.com>
Date:   Fri, 28 Jul 2023 11:06:12 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
To:     Ian Kent <raven@themaw.net>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
 <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
 <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
 <db933d76-1432-f671-8712-d94de35277d8@themaw.net> <20230718190009.GC411@mutt>
 <76fcd1fe-b5f5-dd6b-c74d-30c2300f3963@themaw.net>
 <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
 <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
 <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
 <996e11bf-5f22-3ab7-2951-92109649195d@themaw.net>
 <70d667af-661b-6f62-aa29-a3b8610feda6@themaw.net>
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <70d667af-661b-6f62-aa29-a3b8610feda6@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|IA1PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 90314824-f7dd-4349-f9ed-08db8f06dabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSEXIJe73RSXcjo8y8IYJPlYSUbn352K3pv4xdDsi2uhn0F1hgn7DqjcWT/HEgoCJp2seMBFM2V65CJbBxZzhC+tI+5dksZaCexPGqViyRVK/+sQ+4bnJQ3fH+cwV6Kf8I6sMFb8+aV7CRKfVuJeCJknCB4w0vTFHellsj8zV5XupQ6BfpyaJiLD9uDUSAK70eSdRy1fvHkm02innW9GXr8hfZ/VeAJ7zOv6W+HWBSxZj2AMlTSmSSEx/Z1PRxbsfuwF4vukUH6ZAGxh+ExUo+ErWFGaUbtBH+5nt1RhXeXu1JiJIEUU3HQbRdOB88xhZJfZITzPKlneo+qi6XSEzuHCMOCUrVtrEjIBWhvQPsbW+UDVSAGt5AdCSmVpuqXUMiJHHQB3GDn4gG5b/K2ENOQlzsJryhsI0E4Ncx+ZhvoGOgvSpK07I4PdXCOBGhKJ6SQhFBt5h8FA/r7bV7ckAiGubmW6fp0u+Nf4zI/63PHRZF4RWBJ8+CPD5otNTw6KvBW/UK86jFI0AFYvx6UtLN65vws0ch+nKU5K4kXPCtBQaZA0Q9OOGLOj7I56sKhK8XG52+K5w9SMtVCVr4pmelAMHa9H4VYm/ttrdCQjfOfHLFchocHbJy6Hg212GRGw6pKaUHCzWV797qq0b63aC1urI92FdOqFhGawNTrEWpOwR/aqshB3NSVVXYE1DxMvMm4Da/9yOsFOXnOlopXodw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(2906002)(31686004)(66899021)(7416002)(8936002)(66556008)(966005)(4326008)(41300700001)(316002)(2616005)(8676002)(66476007)(5660300002)(6512007)(54906003)(36756003)(186003)(66946007)(6506007)(53546011)(31696002)(6666004)(478600001)(110136005)(83380400001)(38100700002)(6486002)(26005)(86362001)(192303002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZBcHI2Y0Q4c0ZvOTRlWGp0TC9UWlVodDhvby9NWWNyYzg4T3pxNXVBTlJK?=
 =?utf-8?B?SWR2WldqODVoZ1p3TlJzREV0b0V0VFJOU1Y0b045bVBlV1FSdXkwQU9WVUc2?=
 =?utf-8?B?cnB3bjlObHlMUkJTNDB3MG1hWXpkaEpkZWtoSTBNL1lUMzZXdWw0RlNjZFJa?=
 =?utf-8?B?OWZCUllCS01lVndPdDdjdkZTaG9reU5vWUFTakR1NnJNbGltdkFTZ0hFbm1D?=
 =?utf-8?B?VStCQ3pMVzUwbWhxQkFPYm1aQk5weVU4SWVTNUhUMXlKYmx6Mlk5UDVTOEo2?=
 =?utf-8?B?Qld3cmY1bVZMK1d3Y09ES29JeFFUejFwc1RaM3pubXNqbTBXY1dsOWlVOTB4?=
 =?utf-8?B?RytRZU80VnVvYzZuMlhCelYrdkFrOXh6N2ZNQS9oRk5QWUM0L0VXbk5lQUQ1?=
 =?utf-8?B?MEo1RHNSYWZIdFU3SlR1R1FqaFJrbG1QMG0wOThNTjBWQXRNb2VraXExMk1s?=
 =?utf-8?B?ZXUrUEUxek1zV2NMWEJhRllaZG9aWVVJVUtOSzBPaTJHZVRQNVMrNlJaSjJh?=
 =?utf-8?B?eUhGWjNPbTBLNWIyVEZld2ZDOCtuZkhyL09NUTNqK05ueGhNSnFtN0VYcng0?=
 =?utf-8?B?bDJyUGplUG5LTHVtSWRDMUlnTlVtSDBOdERwL0U1d1ZVTnBGakE0amF6Ym1U?=
 =?utf-8?B?UHRrZVovQVdUSjBNM2JZM2thMjY1cFIyamhzTjQ2NmUzTWJvM1lRcjZlTUxR?=
 =?utf-8?B?L3NEQkJseDZCdVh5MG43aUZXV2ZCWmtwN2tHeWZEUHl0K0E4ZitYS2x4UEhl?=
 =?utf-8?B?dlRWTzQzZ0x2bmZXZS9qeHJFa3BHcHptQUtXQ2V3cEFYNDhHUGkwcDM3NjNV?=
 =?utf-8?B?VDNvRUZpZWlrTEZJMHd3REI4elhNR0N1elpCUlZIMDVFLy9KOUtTUFduYmFU?=
 =?utf-8?B?V2VmMzk2cGM3Nk1KZWlhWTJTcnB6dWRmV0EzekE1bEhreHpDdWxlY1lTZlFj?=
 =?utf-8?B?Mzl5K3d1bkdOQVQrSFd0WU5zdWlkM1FnOWQ3SU1OcmVGWjdxQWpyOVJlTGpp?=
 =?utf-8?B?VWI0a0lmY21aSkRNa0l2TDFoeGZKaGc3ditLRFY0aHhHNS9QK3FIdWVtayt3?=
 =?utf-8?B?ck5udk16YmlQRUl4UW0xV3BOTURyWmF3aHBSUnFtRTBzZUtsdk9QVFp1bTBp?=
 =?utf-8?B?T1F6SG5xUjRiZUp0YWVjbkQzc3ZoRG1aeVVDSHBIdlhEaW9KWWVKZUhBU2ZG?=
 =?utf-8?B?WDZ0Wi9taEIyVE5hSVoxVi9SYkZMTlY0Y3JTeG5ZbVNpSTZSN2pRTjQvdk8x?=
 =?utf-8?B?Ky83V2Fsc0tCcC9EK01Sd0txeDdIck1RZDA5UHJ1Y3lzODV1WXg0MCs2OW84?=
 =?utf-8?B?cGtSODdwc2ZFbkZiQ1F4Q0lTQVJ5clJ4aHl4dmpsN3Z4YkdSYlpYVW1KRHZK?=
 =?utf-8?B?NDQ0SU1qU0JKYWVRSUo3VkYva3pTaElET3V4L0dzandTemlmOVdQL3pYdVdx?=
 =?utf-8?B?U2lkRVA2cUFOS1cvNWQ1YnV0WkJjVU5nZjNMNDZnSk1LNlFyS1F1ZjBVYWE2?=
 =?utf-8?B?ckJUTFphZmovQ0xyK0tGSXVoTU5LRkh0U3J1ZXB6RHhwTktMQnN1eEtHaytJ?=
 =?utf-8?B?WURHZU5nRnhEYWYxZVZqWjlOdjY1U3MwWFUzb2YrMDk4a3JPdFJCeXR1OXpK?=
 =?utf-8?B?WlJrK3Y0MUoxckJhWURISFVPSUFzZVJPNXduUjB1ZlhndHFaKzkxRWU1ejN4?=
 =?utf-8?B?NDd0aTJyQzQwUlQvZzk2d3dMYW1td1RlUCt4dDAyaFRBcDFySktmQUt5Wld3?=
 =?utf-8?B?RXlrRk5JNGVsZzRFWlc4Mm8wU203SDdkblBieVhMZTBNU0twQlU2N1hxeFdr?=
 =?utf-8?B?WnNObGczL3YxdERQY1J4TTVieGcreHJ0M0FqQTM2TWtoNmJ4MWFrUURTTi9Q?=
 =?utf-8?B?dXZLVGw1TkQwaVF4U2x1OHFuVGtudzBWbzJnYkZiQU5TTWw5bWVsTittWTE0?=
 =?utf-8?B?Wk9TTWJ5RFhkbXV1M2tMODVITnJVYjJuZFY1NnJBOFY0dFYvY242czZjWHM2?=
 =?utf-8?B?TmFrM2N4V3JTMm1QaFdUZHc3d3gySGlWTVd6RlF0djByaDhrQnNtSU5VdCtn?=
 =?utf-8?B?N2N0R0hndzZkWmNSbmRTTmJLZFNiUzJwUVBUdnRyQnZIbFFDZ3RiMHZQQXJZ?=
 =?utf-8?Q?zrx1VNaMRPwmow5s4XejV4/65?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTNnb2F4b3VtbDAyQ0VYcWhIcG9UMnNCU01WaDVOTCtCUFVhWk1CbVFzSTcr?=
 =?utf-8?B?ZTVXcHFhd3RUMnp1dldDWDd3UDFEVXRpWTcxVlRrS2ZLb2Irbmh5bXJoNFdE?=
 =?utf-8?B?NXMrOEdRdDlQMWF2SlVzM29SL0NUSy9SMEdReDF0Y3Zuak1SdUZ2clNsbEZP?=
 =?utf-8?B?L1MvS0NkazFCdE41eWpFc01BWnRXaldQdDdacDBvLzUzZkI3MTBZRFRuMG1s?=
 =?utf-8?B?RVZxWEtmRXNMNVhDWml6cDJML3VRUTkzMkZ4K2gySFR4VjRyMENuUi83Z1pW?=
 =?utf-8?B?QTUwVnBTRXdjQ3BXcnAwUkVDUFFpR21HQnhjbmUvN2dobGM1TWVaWEYzemNj?=
 =?utf-8?B?K1JGRm84WlRuNDZydisyTTl4Z1BBcHV4TkU2MWI1Z1VUZlQ4T2h0b21icWQw?=
 =?utf-8?B?QXpUOVVnWGwvQk53YkJ2R0J5WGg5QWFkWHZTTlovdTZvTGpxWC91b1Z1Wkx2?=
 =?utf-8?B?eS9qM2NkSHlIWTdvaDVsVld6VXcwdG51TzdoY25ZTlJjcDBQc1BtSmFNaWNR?=
 =?utf-8?B?b0dtVTNUWEZYaHFLamdRbFZ4MmJxSEhLdkh5Q2lqMlBGZWxmbTJCSm1tczgx?=
 =?utf-8?B?RTkvYzlTamlBK0dOZC84RnJXcS83UXBOTEt6ay8zRjNuVEozRTJOTjJlZWZu?=
 =?utf-8?B?UkQyYjBnVVN3MGhxR1p0dmVBcGpFdm43dTJUZ2xZZEJJWDkzNy91eHEzVnUv?=
 =?utf-8?B?OUY1eVdJSkZHT0hGOVh0ZFRGcm9UZk0wUFdhUy92THFzcmRUU0RjSEp3NHZs?=
 =?utf-8?B?ZEhHQ3Z5bURDWkFQVEcvYXNMcEt0dWF2bVE0WmNYWWlZRTlCdk5pK0RhTFZX?=
 =?utf-8?B?MFFoQ1VjcG1vZ2hQeklYdzdtUnBMajVsMURQVzVyVm83Z3Q3dFV3QTVHRzZH?=
 =?utf-8?B?S2swL3E1WWRFa0RnTHN3WXZYV2o4Zml4VW9LbGpqM1hsS2syeGZzZ24vNGF3?=
 =?utf-8?B?VjRtS1JXZDUvTEtvVWVEeFRORmMya21STmZzQXNVSmtpZm8xaXZqVjgrc0tS?=
 =?utf-8?B?UkZaRjNXZ2lvS3hSUTlTaDc0UERSQmVzRWxjeGJMU0NoZFE4WGpIR2d1YTRk?=
 =?utf-8?B?T2VuMStEYjlaUEZIOTVnYXdJVjJDL3BWQUUwRjBtekl0aCttL29KcW1KMzBB?=
 =?utf-8?B?MmsxOHp5alNETkptM0p4UGZYN2FUc2N5NURIajc4V2JLTzA4U1E4aHlnYmFE?=
 =?utf-8?B?dW9mWS9IcCtwZEZscERpcWlhSEZxcC9mRkNpc3ppKzcxS0ZqK1dUTUVySzhU?=
 =?utf-8?B?S2tZR09VN2hsQVNwakQ3aXpYc08vUmZDbGY5RHdwNzRUcTdjUXZkWFZYanZ6?=
 =?utf-8?B?VWRHTTlZV2tJVHVqekxxUHdPUjU5dko3eGpqb1ZhUWM2T2tBTTFXZnVtd2cv?=
 =?utf-8?B?YllReDE2S0pzcEh0dFVpaHJBU20vc09TVnFCUVZGLzh4NlJsMjNSQTIwKy85?=
 =?utf-8?B?SUE1Yll6VE5wTmhJRXlNc2p1bnRXcWIrY000MXB0cWhGbjlTY2hodGt5MlBk?=
 =?utf-8?B?WkFtRmFicExnWUdIOUJTN2QxdlB5VFZlcytrU25XQjBGYWVmNTRKQlhiRWhU?=
 =?utf-8?B?eUc4Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90314824-f7dd-4349-f9ed-08db8f06dabc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:06:20.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7Kd3ImsS702p9BP+7QwisDBmzX1mRziVUOjzTAbs6mwXQyZa+Fehf3+wFCWqVnZF0+oYAcdExIHoU8ep/v8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280008
X-Proofpoint-ORIG-GUID: aG_zHYRmZ4i9EKSB7PsMM1PwWzTXeYqD
X-Proofpoint-GUID: aG_zHYRmZ4i9EKSB7PsMM1PwWzTXeYqD
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ian,

On 28/7/2023 10:16 am, Ian Kent wrote:
> On 28/7/23 08:00, Ian Kent wrote:
>> On 27/7/23 12:30, Imran Khan wrote:
>>> Hello Ian,
>>> Sorry for late reply. I was about to reply this week.
>>>
>>> On 27/7/2023 10:38 am, Ian Kent wrote:
>>>> On 20/7/23 10:03, Ian Kent wrote:
>>>>> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:
>>> [...]
>>>>> I do see a problem with recent changes.
>>>>>
>>>>> I'll send this off to Greg after I've done some testing (primarily just
>>>>> compile and function).
>>>>>
>>>>> Here's a patch which describes what I found.
>>>>>
>>>>> Comments are, of course, welcome, ;)
>>>> Anders I was hoping you would check if/what lockdep trace
>>>>
>>>> you get with this patch.
>>>>
>>>>
>>>> Imran, I was hoping you would comment on my change as it
>>>>
>>>> relates to the kernfs_iattr_rwsem changes.
>>>>
>>>>
>>>> Ian
>>>>
>>>>> kernfs: fix missing kernfs_iattr_rwsem locking
>>>>>
>>>>> From: Ian Kent <raven@themaw.net>
>>>>>
>>>>> When the kernfs_iattr_rwsem was introduced a case was missed.
>>>>>
>>>>> The update of the kernfs directory node child count was also protected
>>>>> by the kernfs_rwsem and needs to be included in the change so that the
>>>>> child count (and so the inode n_link attribute) does not change while
>>>>> holding the rwsem for read.
>>>>>
>>> kernfs direcytory node's child count changes in kernfs_(un)link_sibling and
>>> these are getting invoked while adding (kernfs_add_one),
>>> removing(__kernfs_remove) or moving (kernfs_rename_ns)a node. Each of these
>>> operations proceed under kernfs_rwsem and I see each invocation of
>>> kernfs_link/unlink_sibling during the above mentioned operations is happening
>>> under kernfs_rwsem.
>>> So the child count should still be protected by kernfs_rwsem and we should not
>>> need to acquire kernfs_iattr_rwsem in kernfs_link/unlink_sibling.
>>
>> Yes, that's exactly what I intended (assuming you mean write lock in those cases)
>>
>> when I did it so now I wonder what I saw that lead to my patch, I'll need to look
>>
>> again ...
> 
> Ahh, I see why I thought this ...
> 
> It's the hunk:
> 
> @@ -285,10 +285,10 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
>         kn = inode->i_private;
>         root = kernfs_root(kn);
> 
> -       down_read(&root->kernfs_rwsem);
> +       down_read(&root->kernfs_iattr_rwsem);
>         kernfs_refresh_inode(kn, inode);
>         ret = generic_permission(&nop_mnt_idmap, inode, mask);
> -       up_read(&root->kernfs_rwsem);
> +       up_read(&root->kernfs_iattr_rwsem);
> 
>         return ret;
>  }
> 
> which takes away the kernfs_rwsem and introduces the possibility of
> 
> the change. It may be more instructive to add back taking the read
> 
> lock of kernfs_rwsem in .permission() than altering the sibling link
> 
> and unlink functions, I mean I even caught myself on it.
> 

Yes this was the block I referred to in my second comment [1]. However adding
back read lock of kernfs_rwsem in .permission() will again introduce the
bottleneck that I mentioned at [2]. So I think taking taking the locks in
link/unlink is the better option.
I understand having one lock to synchronize everything makes it easier
debug/development wise but sometimes (such as the case mentioned in [2]), it is
not optimum performance wise.
Thoughts ?

Thanks,
Imran

[1]: https://lore.kernel.org/all/8b0a1619-1e39-fc3a-1226-f3b167e64646@oracle.com/
[2]: https://lore.kernel.org/all/20230302043203.1695051-2-imran.f.khan@oracle.com/
> 
> Ian
> 
>>
>>
>>>
>>> Kindly let me know your thoughts. I would still like to see new lockdep traces
>>> with this change.
>>
>> Indeed, I hope Anders can find time to get the trace.
>>
>>
>> Ian
>>
>>>
>>> Thanks,
>>> Imran
>>>
>>>>> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
>>>>> attributes)
>>>>>
>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>> Cc: Anders Roxell <anders.roxell@linaro.org>
>>>>> Cc: Imran Khan <imran.f.khan@oracle.com>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>> Cc: Minchan Kim <minchan@kernel.org>
>>>>> Cc: Eric Sandeen <sandeen@sandeen.net>
>>>>> ---
>>>>>    fs/kernfs/dir.c |    4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>>>> index 45b6919903e6..6e84bb69602e 100644
>>>>> --- a/fs/kernfs/dir.c
>>>>> +++ b/fs/kernfs/dir.c
>>>>> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
>>>>> *kn)
>>>>>        rb_insert_color(&kn->rb, &kn->parent->dir.children);
>>>>>          /* successfully added, account subdir number */
>>>>> + down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>>>            kn->parent->dir.subdirs++;
>>>>>        kernfs_inc_rev(kn->parent);
>>>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>>          return 0;
>>>>>    }
>>>>> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
>>>>> kernfs_node *kn)
>>>>>        if (RB_EMPTY_NODE(&kn->rb))
>>>>>            return false;
>>>>>    + down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>>>            kn->parent->dir.subdirs--;
>>>>>        kernfs_inc_rev(kn->parent);
>>>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>>          rb_erase(&kn->rb, &kn->parent->dir.children);
>>>>>        RB_CLEAR_NODE(&kn->rb);
>>>>>
