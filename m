Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63B9676C14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 11:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjAVKUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 05:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAVKUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:20:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF81E9DB;
        Sun, 22 Jan 2023 02:20:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30M5HjX6019516;
        Sun, 22 Jan 2023 10:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1hMjsBWWZXmhfubdpPvob7jR7Fx2uVcc8BxKsHN9tKQ=;
 b=xFZdp8yxV9p4BEDTekoxN7ublPrOW5Si08qxhYe4itlSxAEHXaJQbk2UTJD6FNhyfoEz
 WcMgD/KJrA2ciniD7opUQah4+R/8FGf7asHd4YYCioE002/ly2BQcLxYesU+PuJxtrTn
 j9j6zCQKbwScJ/O/CvmyCjoGuPPtaGozt0hPkHctiUV2PF1+nG2XeUdyLExVAP/HLr4O
 waovg+XD9m4NzVMWyFZVnp3yp5RBqPpgwZqLaqJEYyR3mTOAvqs4M13WGVSQVOli0uW3
 /yz6CRHelWQop3RlhhC05JqaK6K7hPV+O5G7YsHrfgLypGjX2U7KJ3OOeWl/dftK5iTE +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88kts6rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 10:20:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30M9bLEf034159;
        Sun, 22 Jan 2023 10:20:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g2fedy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 10:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V40bfbYZUEGzK4Cm98uhVRy9q/913PjVfc6wN/UOe/4ty+CLYMctV/XIhlOdt4tiO0Y1R9EUH10k2tQsq1ofcFSp3FDth6kYvxsGJyiKOz9pehl/TA+/7V/VAkbnx0jDorGL0yhlcUtq8pOg19w0zPpYapUoLmf5hJhnpTYzsRDN1dWrAzglVJpi5bVSxiS63g9zRNOg79xjW7+8K783Y8H2+Sa0DxWyQg0+bTiYC3uJR1isabxBrx5NOnZUIGfjvAefN5aG+41YJxvHBYXTmbF63Bfym6lUzhIbfUXtdeNAy+XcuL+g82ZGeiuu4grRsH1Lsgt+DT0Trb4nfMMHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hMjsBWWZXmhfubdpPvob7jR7Fx2uVcc8BxKsHN9tKQ=;
 b=KCcjxN7doM6tczMvbMka/Jmgeu7PFso3Hz/LjadzX0v1tmiNi3i5a7kdmrXZtek3+CAdWOowklMTdH2tmCDw1d+3NCXnh5LIv7CSGbQxKz1wwePgLYWz30YbkT55kjHDMJsjLqpFhVEUqNcr4FzMHpwGvfYR3j1Fg63HlSt+s3cEiUxn2iPWFbXvvoqsSRk2kNmBguDpaqG8tD7bhJywpuXihGb5PDm/OBQxWSHYlEgrgA4i4LEBIOKaZXLBx4cG7xn+GWVnfYmUaIoDghWHPOy3JEAV8tvgh1poHbdNem8xwmyOWJup9x89aqVu9r6lf8IsM4eUzVZuoxGuHznphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hMjsBWWZXmhfubdpPvob7jR7Fx2uVcc8BxKsHN9tKQ=;
 b=kxpVjdkHHZR9xCma6I89CqvzqSsvOLk5+t70q4QFSNLrXeTufuZOUGSEyz8l7hCySn2eMUAbMdZ/JyySaCSErZLcws3G5nQfNRdQw4Da5W/6KJ6gustD2yJ705DcXbFE2bi0NJXXvpl452nTfpSkUJb1KLFRfMuQ+jJko+KZH/o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.13; Sun, 22 Jan
 2023 10:20:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Sun, 22 Jan 2023
 10:20:19 +0000
Message-ID: <2d7778a2-c3aa-b77c-626c-43edce261246@oracle.com>
Date:   Sun, 22 Jan 2023 18:20:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-4-hch@lst.de>
Content-Language: en-US
In-Reply-To: <20230121065031.1139353-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: b49620c4-e289-4551-32dd-08dafc624357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u59FZWfE5fmZnSzVKwfKxMcsBfHeczn2dX+UoPzZloIkHG8Dyoi1Dz7tJd2zjoXq42VuTrzGK1MGwxH4jYaItU6QNnmWVZGAC6c9naLcemGuP1KIjU41tkV532KawhBgfsRMNF+OLe67Q5faMi3rJDS25mDM1Us9Td/O3evzWfNPPJh6yVlLuGzvr5iIYKM09hpFSdAoMbXuIBIu+2jjWSKiZ7fP9ckY9sz8jTHzn6/scFuSZrf3EvVd7nI2vT7MvQsevhyGCG2RR0UjbDgWxYA3vRiY8eljem/CkXXAPIfvoiCasAdfPDOGRqSMe7vF+WahHK0c6hQjLSdEEZvnkeXcOjee2GSDOWhvk/AI1kdyEFV27nH43vWtE749LBw69AG94Zn3E8FJmp1ixpAUCoR/ze8tP8XAQ3zOl2pKz/LZWgjQdWSO5SSJzkXcfsKgYWlTy/C2jd+Su1hUC1apPHu1pb/sge9ZP2HMLEE802ccDqZvGKdvBLZLc9ZO4ySDilyRat7zNgEWFR/Lgjn6efNLutkF8exRCRv3jdSRkYbHMYeavs359ykIJGMsnx6qgCry9XarQvQECtL4TalD0JOomPsjnZH9O5EF056Bw9KMgOXPKK02zah51kVB/sDduBG/hvleLApNUTNOqVXm82Z6upfaj3FtJDvQ8NF9pYpt2ilGOOKU0LurNo1tlkYIfPklyGi5ME4Fb9gmf6eYxHiepcQa3GqVsmvuju15TyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(31696002)(4744005)(2906002)(44832011)(54906003)(6666004)(6506007)(110136005)(36756003)(5660300002)(7416002)(8936002)(31686004)(38100700002)(478600001)(2616005)(53546011)(26005)(6512007)(186003)(6486002)(86362001)(316002)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW8vYWVWWmF4SHcxSDFUV05VeFByR0FSVGxFeE9nTlBzQkJnSWhaS1FMdlJT?=
 =?utf-8?B?MFUzSVhlTUVmcUpqYitBWEVoa1EwTVdkYWlnZHd2cDJyd25uTmZJVGs1V0ZE?=
 =?utf-8?B?RDYvQmd2aXBrei85dHJLM2RkcUJ0cHpRUUgreVJ5YkhoalFuOURmbjBZYjNB?=
 =?utf-8?B?Nk5wRDdkSkdQbllqTGsyRmgyU3hnSmdYTWN2UGUwRFZaWUFzaVlLZ25EZTN3?=
 =?utf-8?B?bEF3Y1V1dkRKWWQxQjFkUG9HOWxxYmI5bVhTWld4emsrRmM4YjYrUVdkZ3hl?=
 =?utf-8?B?OHRuazRHUzVxSkgxUG1OMGI5QVJna05GQlhjVEpyczBnN05NVkY4YVVDaGEz?=
 =?utf-8?B?Z0M4bkpFZjJ0UDI4ZFEvUVNEV1V4TkJjaHlHZk1lMTlRS09RUGE0eHlqR2o5?=
 =?utf-8?B?QldvQU82R0hvV3pPR201OFJVZ3ZSTnJXZ2J5NTIydGdOTlQ1UUlzeGJpQjFD?=
 =?utf-8?B?UGJuNTJ5U1A2QThKTlhrVE5EWWxkODZRd3IvVWkxQWJtN0RyMkVYN3E5TThs?=
 =?utf-8?B?NFQ4V3Eva01nVXZBaituWTZDbEx1aFpmeExUOENIZXJpdUZHbk8vYnZTOEdj?=
 =?utf-8?B?SVR2V0dDWUFpWWRvVWJkSFBwWXQ2cDBoVVZwL2JIUjBUa0w2MWk0RVBJOTRK?=
 =?utf-8?B?bDlNWGNZM3VUeTZiS21UcXVCaVd3aVNDMWFMTWNYdDFxem50aGhFQ1pKR0VI?=
 =?utf-8?B?cGFRYTlJVm5lSm4rWTZ5REJuZnVFdmtCK1VUbnBJQmh2aEZhZWRTMzRrWm9T?=
 =?utf-8?B?SHZYQ3lOeXZsOFBVWnJtSklOMWdpdDVVTFNZbzFJN1JxL0pCQUh6emNTUHUv?=
 =?utf-8?B?Sk5UajdZT3N6V2owV0U4aWc3Q29BS21iYlZTeGVmV05ad0VjSithaXE0MlNh?=
 =?utf-8?B?b3p1VUk3eG93TmhRTkRFR2VsNWdRUFpQQjNSdGNTSGljYmRVZFUwNnl4YVhT?=
 =?utf-8?B?WkdlM3g5N0FhQ0x5RVV6L21lOC9FcFhlbWxkcUpZVEo2L3daQkhGdWJ6UXlS?=
 =?utf-8?B?cjBwMEVObnBVYmdHRGxWbnNJcU4wRWFqa3ltaEh3dHBTWjVpc1VlTXc5WEVj?=
 =?utf-8?B?V016MXZIMkR3OHEzUWxnYkZvcWRBendjNWlwRU1XK2NQcFVBZXVCWmJNcy81?=
 =?utf-8?B?QkxGcERlUy9uZkN6azFMWFZyTFd0ZVgzNngwRDY0WXdqb2IzeEtFc1prTHJ0?=
 =?utf-8?B?QmVSNW9jQlptaXhuTUV1Y1N1MGJWcm9qMS9kOWk0bnpyQ1B1dDlJWmlxejZI?=
 =?utf-8?B?S2VXZGVMMUVWYVZnY1FzQXA2SXZmR2ExbmxiSzhpY08rQ2xDeW1iSk90ak04?=
 =?utf-8?B?aE5DdFF6T1luejFpclhoRlFhZ2N2UXRNNnRFNktncWZRUE5tMnI1RmxzcWFu?=
 =?utf-8?B?QTZTeEh1V2llcEFYZ1NPMlA5ajZGUGtSR2w4MkNDMHFQenlRdlVxVytnYVR5?=
 =?utf-8?B?dVoxN2VzVjB5allQSkk5dmRwME05dGtCKzJWMDlGaHBjTG9RbzkrL3VCTUJu?=
 =?utf-8?B?NVkxd3JsSzYzSUVSbGNJVzl5L09XTzROV2JVOHhVbnVDMHF4eXJTdlhyUWFj?=
 =?utf-8?B?UEdDcjNiczA1TVd1ZmFnZkNJTFRIMUNkeEFjbTFlUWg5dUpaOVF3bE1IRDN0?=
 =?utf-8?B?dUtCem52TWxsbUw3YlhlU3hzUHVuRk1QeTRjT093TXRHOEtmL0xSVkxFY0pj?=
 =?utf-8?B?M2FEa1VWYklkODFNZ013bHhjNUlvS2syOVhsdmxQM3N2QWZGSjZkYWJTeUE1?=
 =?utf-8?B?ZnR5QzAwMEFHVjVHbGlweGlvdUNwSGp0NVRwRys4eEU0dk40eklkSENEdFNk?=
 =?utf-8?B?N2tDT1JDZzUvVlJBZXp4V0hBZ2VXQkRVd3Izenk4SVpiOWk4bkU1Mkd1WW9m?=
 =?utf-8?B?RkNxN2FFS0luQmRjQlBRUHIreUtmNkNkZ2ZuUW1WS2ZWYUlIMW5VWFdUZ1Ez?=
 =?utf-8?B?d2l2R2hPY3NxSFZ3WUdVaVlwM1VSR3h5UDQwSEJ6WWtKaGJONm0ySWVMZ3or?=
 =?utf-8?B?Ym1wV2FqdEFQaStFMkZBTVZCdmpneWVnSEt0WDMxRzVyakk4ZWRXSitzbTBV?=
 =?utf-8?B?cHlXWE1BSDVvUGNTRWdmeVFjaXgxbk81QjA4TlRrSnNIaXVLeVVvbXFMMlg5?=
 =?utf-8?B?TTVaV3cza1JBTG1icVloUU5KSlZWeFRVZHRSejRiZGpGK0M0NjVsellLUHJV?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDNlOEQ5V0R4YzZ2Y3NJNVM2b1pZTEtmbERXNnEzOUVZTjJEekNVVWNUVkx0?=
 =?utf-8?B?b3pqdUxIOFphNWZKZ2xJemZPV2oyeVNnRjhHL3BZS3B0NEJ3dksyaDF0RU9W?=
 =?utf-8?B?QXFZMWx5WmlzS2tZT0p1NVJ5M2c0WlNpL1VwN3ltWjNJcjdjWnh2MmpuWGJC?=
 =?utf-8?B?LzNGUGpvYnhWUUN3VGZSTzhhVUxSeFpWK1ZDMUg5UFJ3ZlVQOU9WV283dEFU?=
 =?utf-8?B?NEhzbno4aUxxTXJYdDYvcmhRYlZGZGF3UXV6TnptSkdteGRzYWNHV3JXcFJs?=
 =?utf-8?B?SWVFbTZERVRTcGJvV0RWSDI5QWdzWVUvS1MwWVpZUEVVa1NpWUNiME1xYzM1?=
 =?utf-8?B?RGFReVoyMzhEZlQyemU0bXpoRmJjcnFtTWRuRnhrQlJIbm11cHd0Q3NZRlll?=
 =?utf-8?B?MGE4Q3h3Tkw3V2JGQ2JkWk1QZDl3bThaTEdyNkZPODFlRTY5dzc0V09kNFBi?=
 =?utf-8?B?aDNyMkNLMmZ2dTRhV1BwazUrNGpvVXdrenRLVDkvVGdwTlcyWDNFRWFRb0FN?=
 =?utf-8?B?TUlZVnE0QUN3MU9qZmJTNjlSYW1BeXZ5Q0JmN3ExMDFFMnJPLy9YUE1sY2V4?=
 =?utf-8?B?R3JOVGFOUUdCZXY2WGkyN3BObFFJTWRNekd6R1RjVDdCQklscHV0RmljSkN2?=
 =?utf-8?B?SE9jdmxlM05DWUZ1dlBGRTNsd1FkeTlqTjZMVVlMVk5MVDNKNllhSndSTlYr?=
 =?utf-8?B?aU5tR211aDlVT0Z2VlJJalRxelo0UjBlcVVLNzdGcjBtUXNRb2tQUmZTSWVa?=
 =?utf-8?B?M3p5NnZWTkxCSWRtZzk3MXo1RVdTbmM5YmN4M1ZIUjRBeDRtMFg1aFd2N2g4?=
 =?utf-8?B?NzdPVk1FTW1NbGFSVkhqdUF2N0Ywd2FTanFQRC8xK1YyZVp1am55eklLN0xa?=
 =?utf-8?B?SkRHNzhOTEFYR3IxUit6eGRpQm5VMXovNUNpNURrTE9WMDVJUlJBanh2WG4r?=
 =?utf-8?B?eXhUcEtLVzdyYlhRdHJWTnFIVk90dE1TQmdmdkNoR3ZaOFppeCtqSkk1MWRI?=
 =?utf-8?B?c29TL3V2NHBsYlZqRVFWSTJwYW5OL2RWVk1PL3V2a3F4TlVsaDRTSm9UWXRE?=
 =?utf-8?B?a3dRWGJYVXZPbG9iakZVUmt5N3F1K3R0WVVhMHl6TTZCNjFoc0ZuMWkrUHh5?=
 =?utf-8?B?ZFUwY1FhdlRHOCtXOWgxbERRZGkvc1FlMkFqTnVMeHRWNy9vY2ZjNXV2RStz?=
 =?utf-8?B?TTZIYkxBWTQzUTlnOFd6MDVpQk9ETVVzQjJUZThKd2o0WUpicHcwa0pHV05M?=
 =?utf-8?Q?y46oM7lqdovx2cy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49620c4-e289-4551-32dd-08dafc624357
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 10:20:19.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYqC51ZlX+VrHovK+QiZKwT8/ymYZfnIXoPUXiHrXrzr2C3igP4Iu+3US7q3hJELqhfRsWqIwYAZXjo9L/jgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_07,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301220100
X-Proofpoint-GUID: sEtgXTB3eIpYAzLy7b2Y-9hpAtwg13gh
X-Proofpoint-ORIG-GUID: sEtgXTB3eIpYAzLy7b2Y-9hpAtwg13gh
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/01/2023 14:50, Christoph Hellwig wrote:
> All btrfs_bio I/Os are associated with an inode.  Add a pointer to that
> inode, which will allow to simplify a lot of calling conventions, and
> which will be needed in the I/O completion path in the future.
> 
> This grow the btrfs_bio struture by a pointer, but that grows will
Nit: s/struture/structure

> be offset by the removal of the device pointer soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
