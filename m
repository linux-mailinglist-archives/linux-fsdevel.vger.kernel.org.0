Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B327644DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 06:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjG0EbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 00:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjG0EbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:31:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD52704;
        Wed, 26 Jul 2023 21:31:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0uoom016521;
        Thu, 27 Jul 2023 04:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jVtjMf4+aWJZpy259O2cHcLny78jNALAK87LgRatGD8=;
 b=dUtJWgeF+u3eDZ4BvQrLCMzNpH4Ect330WFmVWfYVjWKgfqhZvg4Tptgu3dXX2EdmieH
 spAZFYZw9ReFvaEZ9aCRNxstVUhNZ/7oCt/I+xLk7er7Noae5IlTgl6H749CJ4QjBZkN
 bkS9si2yURF/oLrjl310nk+q6YLH5JRsDLy6MNuLm6FI6aoeWdK12hE9cZYeKukNRYMx
 kMer66CLBboFMhZ/7aFMDJjYr+qfP5IHDppHf6Hxx7BAsco/UVRakX9H3+fnTMBrvAY4
 f24HGthGTPalk6IgH6jDQNh0ECFHMUHHGNb1U6Z3l4qCj03b2hD1pMLrCocTR6qAUEVb xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b0udm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 04:30:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36R1Ve5Q030414;
        Thu, 27 Jul 2023 04:30:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jddf2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 04:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/3yu1S1ilJUgl/VcD6thkXT+NXwpZKWHwL9ZfVJH2JjNePsRd9AGaUIF74e6PE3MyHw/kGb9iYYi7lsmKhnx8hf7rGVnJ8Ns6N8LQ2JrKancwWcKdEFODoHcvekAmOtMIvea+5xlA8u/k+BddW3Cxn83OKX8TShDtoLny+K3HkBxy91ywqu9J4ctSVFPd076UdbolyfCmXQ1jDFvSikV4H9//SaStshMmTyGn+JPnqrhiGmFuC3l5fEA71PID6aMcovYwo8SO0aYNKbaqzQMfKYRhgOm+eKmU0gB6TpaGijW96pncRoyHJ5WsI27XqEK8xS2CXnDCFMw/z/EUr+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVtjMf4+aWJZpy259O2cHcLny78jNALAK87LgRatGD8=;
 b=a0Eh+f9LTmQICY8MZiw9uZ1zbKpNGWFb7NNKCx2eM21S+2DQnDWK3Kii8cI8Cr7WU4f9TOoSZOHu08tzDGD2oWXvDZKZWDsWGIFYYpCiBISj51yg+FwFvUT9s88AUkRhjrRnAjW4XFNS3ZYlOP3poLjn+p/YiIDynX4LPIjV2+tsL5AaS2BVit/o1SwoeALZHZXfKQS+jBEYriMi1IZkUjO8AsLc80vP4Z34tQopX4FeYlc5n8EH0TKixeagCrcKf77vfqmqY4S9M7/1yK5mzJkFKqlWMqyz7DJMuvdlTV/H0JThKFZO930KEcu1+N2zqgqv3FGl+fp4/FLV4EdjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVtjMf4+aWJZpy259O2cHcLny78jNALAK87LgRatGD8=;
 b=HEV51G8KjiHHJHCAJ8YPqkVwDZOUHzSTYfLclVPTEFvv+J0+fvbVrzGvZQtmwuWFj5H4HM4WGHnwrtv6CiuiK1AgbP7s5I8fI1SXLZLJExmfY0TiEI0b5sAi5N/1HBIugTwTReeru2AVhV6jgV6Cx+xxyArxpTLUZdn6WH2awnA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 04:30:54 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 04:30:53 +0000
Message-ID: <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
Date:   Thu, 27 Jul 2023 14:30:42 +1000
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
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e17fd4-f840-428a-2167-08db8e5a4358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsdgcJbFfS44UYjxsTfAwKGEKsm8LKLPsVSGXOkIgAsbj9twMFal7gi8q7x9+Yhmp9YZo1zrIuF6x/PArNrcB5H5IxhlnIGcBfa+gaDTP1F5J9OlMZ5kCnuwhWDZVtmptrsnXbTEmiHLQUim43DXSatZsw2FE7T60urpLz7DbAyWO/Wl181DMDtr+Ys2bamMI3lFJJIdzw8f+sXhT7dZ4O08znpxonDujV8Cx/rIOEOcD5gspXdQ3tVDEK5Zcsx0/cyKZo40MSIB14JJWQCzUfHHJDtxE6ZIml2/e+4kxT85+pblPX0tg4JyfKK7PiPWDDBWGcM+y4i11mqOEKbtcZMcs9A+e+wQPyCrjx74k1/VGh/C9dk5wAxamUcBI8hCprJoWLDkbTqp08vx+FA+4836chp2N85ed571Y0MAihqt7VNyYPASK2SFNn7zeDqosIR7GQva7YzasPVdj2a3nX5phsYwgnrk2XNos1lGR8nNmADP/5YluAGgbi24zn3jbsnj5pRizdEVb9ZTKPeEXwl2z4n42CH93P7x1cNgAYasp3cHfL/Fp8jWHuejJ+soRlrmLns3zMCn2FTbK/fPITn5Ed+A5pWnGQiJ95fU7O4NY9R24S9hOvsDbW4nQiq3LbqIZmFND070TEqjB3C44i9gccvV2vwL6t65lYgfvYggqBmMV+d2XByBG5vpntWN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(31696002)(86362001)(186003)(6506007)(26005)(4326008)(66946007)(66476007)(66556008)(53546011)(6512007)(83380400001)(2616005)(31686004)(36756003)(2906002)(6486002)(66899021)(478600001)(110136005)(54906003)(6666004)(41300700001)(38100700002)(316002)(7416002)(8936002)(8676002)(5660300002)(192303002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW54MGM1SkxYTjVxdUI5R2REcGdxWWR0cGpFcXExdlN4bks1WWJITXZteXM5?=
 =?utf-8?B?QU1pRmx5TXFoZ1RrSjE1dnVFcG4zR3JBd0xISVdqRklaVUVQN1hrSklUOFMz?=
 =?utf-8?B?cThCcy9TVU1JOVhsZ2N4Qk1ITG50ejBXUStEaGsxOTV5QnFhYko4Z1FxL2wy?=
 =?utf-8?B?Q3hqVy9jbGJWdzM5akFBNEo1Y0Y0Vjg3TjJBMUx0dmVESXNlM3A4Q1YvRy9a?=
 =?utf-8?B?U2dYZVc0Q2JjOXl4RklkelFMdFZkd2VKOEgweG44U1N6MUpMclI3NXNUOFZH?=
 =?utf-8?B?Nm04MnVBVVZkZTlLTGNvZjBTRlVzcndHUmt6VlBxWCsxdCs4NjQ1dXc3RUFs?=
 =?utf-8?B?d2lIWW9rbGpPT0lkSnpFUlRCZ2VkYjF2d0dKa0pGQXR6S2xERmJoU1FjSWlu?=
 =?utf-8?B?NW4vV08yaTZvUjJtQUdBdllRS3A4d3h3eFgwUER2cW1ncGg1Wng4ZDcrQ3JC?=
 =?utf-8?B?bWdTY3h3SWR2OEp1bzJjL05sb3pYSGYzeENPRWtodXhkR1hmaHVMZUNkWFly?=
 =?utf-8?B?WGd5enZpMUtiOFRyT3BNM1hjUkpTTXk2cFZHZWRqbDM1N2pZNm5ScEROZzc3?=
 =?utf-8?B?UXo1WDlzdjNuTmlJQ0tOK0VQMHgxSFFpS3R0cDBRWlQ2SWo1dkoxK1Bzb3Fh?=
 =?utf-8?B?NmM5Y1laUXUwdnVLMEhHWmRJVkNscDZ2S2VTVWhUaitZL2JaVGhtOE96SFA5?=
 =?utf-8?B?Q0JsS0VWQ0VocXpJT3BoM0NxNXpMZDRjMFdZOFVyRUNrb0h0bmUyR0pvVXl3?=
 =?utf-8?B?b1pqaVNteG12RlN3dnJOYzFOR1JXSXV5ZjlJSStWTlQxNjBMOVJsYlliTVNC?=
 =?utf-8?B?SVMyL05oZFhrQ2h3MXZiR2Nhc2RDaFFmaTJaSDdjcVJwNFhnbWZTR1VmQmZR?=
 =?utf-8?B?L3c5R1NPTnU3RGJvQkd0QXR0UVZyZXQycWI3emJ6WjhQSzVQdm5LRzFmNDlz?=
 =?utf-8?B?dTUxZHFVeVcrVXlzMjBZMXh3ZWQxdjZVek91ZjhDd3lMU080YkNaaXNqM3Ni?=
 =?utf-8?B?MU1jWXNQMlF6YjJuSWkycklxb293c3pWMVRBZld6WDBCY0c0MWVhZG8zVVUw?=
 =?utf-8?B?OVNWL0VXMEIvQUFZR2NGYmNMTTJmbmE4ZDdGQTVpblY2QmZVSmJjOW4zdkg2?=
 =?utf-8?B?UmQ1a3c0UGdpQVdPaWhkeCtnUTc1dG9HMjU1UTFmY3pneE9tcUhsYm5JUkZq?=
 =?utf-8?B?WVBnT3RYWENwd3d1T1J5SUswRk01VVZpSVBxcHZuZEozaWZWNkt2S1NNT1dH?=
 =?utf-8?B?UzhBQmtNNGRuTUFhMFJ3bG44aDFmQXBwc3lGZHdFSlR1OVVVRUN4MlEraCtM?=
 =?utf-8?B?cHI1SzVhOTJoeXZCbWdFVDhTSldwbW5oN2N3SXluV0FCK3dRaXE3Qkd5YjZh?=
 =?utf-8?B?WXVIM0RWTksramFNNmMyN0g5TDkrT0JCa0hiaHkzTGRvZTVNeGVSdVJaczJ1?=
 =?utf-8?B?Y0Q4YzlVMlJwa3p1dFVVTjhrZDMzcjl1eVN5YXFYZUt1Zkt0Q25yWWdLd2Mr?=
 =?utf-8?B?V3U3eVRyNDlpUDlDUytjcWZJcVpndDA5ZGVSRjg1VWZ6VU5GZGpoTjJOaU1s?=
 =?utf-8?B?RWdNd3puZE1oOGFqWjRlY1c4RWN0Q0hqUUxFbmJ5bWhBR0R2c0N6U25DNXNK?=
 =?utf-8?B?ODNnVGlldHhWSnVUQ0d2K2FWWEk3cjY3ZERwREZ1MHNreCtqNndXYjJRZFRF?=
 =?utf-8?B?dHlZbXBFdmxETkEvV1M1bDFTMlpVK2tmWWlyaDliSTNrVXIxREdnWmN2d0RQ?=
 =?utf-8?B?RDI3TGdra3Q4NFcrN2RmNk5YYjAzT2hoR0RWNzk3SE41c3lQd1kwREVMbjYz?=
 =?utf-8?B?SEYzNFlGeER6SkVVaDM0d2lnVjAzcU5OVzlLcklITEJvTVFpQ2hSYWJNNGFQ?=
 =?utf-8?B?MmJINElaMFQwaFgxbk5hbndob2M4VWd2L1FBTk1FMDZwbUNWNkNZZXZqU3Zi?=
 =?utf-8?B?L1FjeWNVQThsSVppZlRPTkVwL0JSR1ZtQUh5QXpIMzVIT2NocG56K0FTZ1Vl?=
 =?utf-8?B?WUJYVWJRYmRIditQTkV6YVdQaVBWQmZ1d2R6Yi84cFZ0eTNSOWVnYW0rS2k2?=
 =?utf-8?B?NEh2bWhxL0QxVW9CWklRY3JMSXNWdU5MOXN5cU1vTVU4dUNCRlJ3MEFxZzJq?=
 =?utf-8?B?cGh3UGFkVjJ1TDhWMEx2a2Q1cGtXeFBOLzZiUm95UVdZZU9LSmNMMnIxMSty?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S0NONEhYUi9lOVowTms0UjZyaG5VMGVieG56bnFGeWppUWtTbExtL0x5cGdM?=
 =?utf-8?B?cGNobE5oN1FqZXovOHlORXFXS3hLYVlsSVovY1Rha1ZsYVNGY2g4OElHZnpV?=
 =?utf-8?B?QU1EaTd2K3pXdFlEYzBFRGNTMk9wSlFFc1VPV2diaURQeExmQU1zdC9scWJX?=
 =?utf-8?B?UHZxSkxyUlJmVTUxZStLcWcrZ3Z6R3BYM21KVVk5R3E1a2RQRm5HYzJEQnFk?=
 =?utf-8?B?dlBXTGFDZGVLNGtJeE9DTFl4aktNK1pwYzFnZHpTcDRncytmQXFMMjEyYjFK?=
 =?utf-8?B?RkZJSTluK1FaUFVMYzBKc2Zuc3J6b0JFaVI4ZUVFcGI3RFZPaTdpWk1UME9B?=
 =?utf-8?B?NWQ5RUI3VVBCWEdmLzVnMDdIQVQ0SWwrVGFEeTBCVEtaMmZHSTR3QytzYzhr?=
 =?utf-8?B?cGRTWi9va1Z2RWNjSFJ1SXhPZEZuQ1plbnhva3pQS1FhdzRzVE1WcEVDbmNk?=
 =?utf-8?B?U1MwODBOczk5T0hiUVRvbFJvNGgrWm4wZy9XbzhVZHJnV3lmS242SlZadXJT?=
 =?utf-8?B?cXhqU2UyVmpMZTZXejZiM1Z4MS82WEtKM2ZpSXJOdmpKYitHVnNOV2hvdG45?=
 =?utf-8?B?bzlEM3V0VE1OZlNrRE13NkNpcGpiSTd4RTRxa0Q0dXZzeHI3Q3YyeUlLSklK?=
 =?utf-8?B?cWJvMFZ1ejhhVXkvQmQrTWppS3BXak5wODIzbjJLY2hCbk8ySHk2QlYzdGpk?=
 =?utf-8?B?NDZxR3NBUTl6Y1dsYmo0UUFxNS83YndvaFpxbGdJeFBJS1dFdEN3Y01nSEdS?=
 =?utf-8?B?Vko3TjZta0o4TTRIRG1WenJ6NVlrRW8wZ2htMldjU2htQVg1S2pqaHJsRjRO?=
 =?utf-8?B?YlNVQkhXdWZITDBLd0l4OXhTU0ZqV3cxcUl6V3hlWTlsQk9uOEV0VUJ1SUF3?=
 =?utf-8?B?UnRnMkxvRyszaDdaTVBWNU5mRGtMV1pNSEtMUytMeUZ2cllYVUh1UUxnQVNZ?=
 =?utf-8?B?TWRONWtET3dCVVRSMXZoSm5aUm5JUTJpMHc4SVVycFhobnczS3Z4VnRtLzRK?=
 =?utf-8?B?N014U09jRHJiM1gway9OQ2Z3WGlsc2lLUCsvQXhZcXNhV3NvbEwwWWRtS0pT?=
 =?utf-8?B?S1pZbVJRYTJ3TkozR3lhYUI0dmI3TmRVOE9aaUoybUdnMG5nZlNFazd4RlNl?=
 =?utf-8?B?am5NdUxEVjJNMFdxM2Q5amE2VUw5SFlTYWhhTzZVTmF1M0dBYW1rTHR4TFA3?=
 =?utf-8?B?RUZNV1dwMlh2bTdjZzNSY1RSVmpsU0doZFRZUHd6U3M2N3RtK1dZbjg1VFhx?=
 =?utf-8?B?N0FjOGFsR1hVQUhxN1JnblMyT1N1Y3hsMzFRdmJRT0pKbW91dVFOV1kwTVhx?=
 =?utf-8?B?UWV5M3dBbmIvaStITVRnOGczb2h2WWYyaFAvQVFVK3FKbWVMclNsUFJzaUNi?=
 =?utf-8?B?OVpuYlZFU3JzR0ZNcFhvdzVtcDdtQ1JOMjVJUE9sS2E2QytzUlJPdkRrR24r?=
 =?utf-8?B?QWFEd3huKzNwdG43QUNCUHl2b0p5Wi9KUmhneTUyMG5JVkRzd1F0NW1iUFVU?=
 =?utf-8?B?Tlk5TnVvbTc2RWhpckJPd1hWWEZtZlJGQUgwTVlRYzFabG5jZ3VWSkRlOUE1?=
 =?utf-8?B?ZlBoUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e17fd4-f840-428a-2167-08db8e5a4358
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 04:30:53.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkZrK8+RSD23NEZo0LkzGAbu+SQHXS8VtBYarsmDTwrf9Y/oLd4b2lWnqzxL8uFEEc9sIIP1LBr83We5CaPtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270040
X-Proofpoint-GUID: gy3kJRgwFeB4AHZASOBGTkVGtyMdKzb2
X-Proofpoint-ORIG-GUID: gy3kJRgwFeB4AHZASOBGTkVGtyMdKzb2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ian,
Sorry for late reply. I was about to reply this week.

On 27/7/2023 10:38 am, Ian Kent wrote:
> On 20/7/23 10:03, Ian Kent wrote:
>> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:

[...]
>> I do see a problem with recent changes.
>>
>> I'll send this off to Greg after I've done some testing (primarily just
>> compile and function).
>>
>> Here's a patch which describes what I found.
>>
>> Comments are, of course, welcome, ;)
> 
> Anders I was hoping you would check if/what lockdep trace
> 
> you get with this patch.
> 
> 
> Imran, I was hoping you would comment on my change as it
> 
> relates to the kernfs_iattr_rwsem changes.
> 
> 
> Ian
> 
>>
>> kernfs: fix missing kernfs_iattr_rwsem locking
>>
>> From: Ian Kent <raven@themaw.net>
>>
>> When the kernfs_iattr_rwsem was introduced a case was missed.
>>
>> The update of the kernfs directory node child count was also protected
>> by the kernfs_rwsem and needs to be included in the change so that the
>> child count (and so the inode n_link attribute) does not change while
>> holding the rwsem for read.
>>

kernfs direcytory node's child count changes in kernfs_(un)link_sibling and
these are getting invoked while adding (kernfs_add_one),
removing(__kernfs_remove) or moving (kernfs_rename_ns)a node. Each of these
operations proceed under kernfs_rwsem and I see each invocation of
kernfs_link/unlink_sibling during the above mentioned operations is happening
under kernfs_rwsem.
So the child count should still be protected by kernfs_rwsem and we should not
need to acquire kernfs_iattr_rwsem in kernfs_link/unlink_sibling.

Kindly let me know your thoughts. I would still like to see new lockdep traces
with this change.

Thanks,
Imran

>> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
>> attributes)
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> Cc: Imran Khan <imran.f.khan@oracle.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Eric Sandeen <sandeen@sandeen.net>
>> ---
>>   fs/kernfs/dir.c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>> index 45b6919903e6..6e84bb69602e 100644
>> --- a/fs/kernfs/dir.c
>> +++ b/fs/kernfs/dir.c
>> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
>> *kn)
>>       rb_insert_color(&kn->rb, &kn->parent->dir.children);
>>         /* successfully added, account subdir number */
>> +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>       if (kernfs_type(kn) == KERNFS_DIR)
>>           kn->parent->dir.subdirs++;
>>       kernfs_inc_rev(kn->parent);
>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>         return 0;
>>   }
>> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
>> kernfs_node *kn)
>>       if (RB_EMPTY_NODE(&kn->rb))
>>           return false;
>>   +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>       if (kernfs_type(kn) == KERNFS_DIR)
>>           kn->parent->dir.subdirs--;
>>       kernfs_inc_rev(kn->parent);
>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>         rb_erase(&kn->rb, &kn->parent->dir.children);
>>       RB_CLEAR_NODE(&kn->rb);
>>
