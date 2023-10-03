Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7467B6276
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 09:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjJCHYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjJCHYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:24:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8483;
        Tue,  3 Oct 2023 00:24:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930jwF0022813;
        Tue, 3 Oct 2023 07:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wQclyJ7M0hA/iVz4qYMIGqduTaq/fA2H+b+ngEljo7M=;
 b=27qGsvyXvTJUH1d5p6fp+Il9L6T7JIEqoUAUDxLYyT/hof/EpCJ80ZvYmaqjppJ/kjni
 xNKsEuyG7/jP6YYHU80Da+2kT3oO0lpq+1RvB3uukW6o2T5Kn1NTo93XcZacHKwFezpj
 zh77bpm3gwE3Y8p5nLdg78Leq/D+vrDpNiwrVBpyY0ZjueyFhNCEbqNCKhCODlMSLGCj
 pfdTLPTeBERnfVsFZr6m98No+DH5UCMYP4GdeP5gPVxI7B9a6w5hF+796le0YhqC0DoM
 XVAf+RXXpj6EFcAS9I0YjM7SlglGxIdzNS10k1RuYf8iuF0fbiYP6DwA4ihctfnwUf+s TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcc32c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 07:23:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3935ZeVw002864;
        Tue, 3 Oct 2023 07:23:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45jdd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 07:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZK/arb+svcd5ZYYHdM/86wVvoDIAr4YoIoAuO1zcgHtGaK5eYQ8Btfd2SRpbmH5up55NjvIr2vWMlRefmSSwkxTcX/bC0fEeeLOdqHjvqWfn++IvvX4WAeaBVpxZwq2HMtF/xIdFF70czg3OTK9rpfFH6x4XvbmnPGWhlEfY1amBZwdL5o7MR6MDJwq5zbwEy8I1DjMuQ9e3kZy4NrL/tHkEhoCx51Q4v5SnuLXrKo3Tg+b3qd/a44mAl3owsSNTPuQLrRSYT/NFTXn0WoUj28jpfQUW04ZyyxD6fbNuYK/E2iZhGQ2Xl9RR7wglDWx0iyjUe0XkL74ZJURSx2a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQclyJ7M0hA/iVz4qYMIGqduTaq/fA2H+b+ngEljo7M=;
 b=bsOR3qYlCC2EPAIw93Tof034BdZmeUlQUukKopvceiJJfFIXzKQgC4R+mvuUajm++t6+lCA3vtxT3UnlYR3XpazhMSzNxhGhb/W1+R2Nu6FHvoXbYC8TNDXZps7j89MI5nuarsbXOxUnY+4uezFJsL2kyL7sx+tcwVgKn9V36i+wIORw4Qis0vFiXmyVUEhlj2AnPAIxHx8kIwbHPWIXYEpOhVpmDyKWuYCryl9oasCPhkL4guzV6ykVYTfYTM4C1ObNKXjMUMmWV9u88o4z0/U3T7yTslM5DlDOnwabtGdGmPGZHOjqk0FEthrN/8XvGOiGb5+yM28Ot5jnytt1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQclyJ7M0hA/iVz4qYMIGqduTaq/fA2H+b+ngEljo7M=;
 b=MhIdjLGojzZVhqmdOXHDEL+hO0P5UPsd8Bc+ar4W4sLKATV9FEbhagbqfaj+yZcoc3rR9fxJnreJpXM4wxS+nN98kRlK3ghYKCNqeH19I8RSvp3U5/2C3edX1CWBwswiCz72l7kh5TyXyXOHKJl+aj9Njto0NHK0ZDooFTyXXd0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 07:23:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 07:23:33 +0000
Message-ID: <da12e81d-cf29-6dd3-b01e-2319aa9487d5@oracle.com>
Date:   Tue, 3 Oct 2023 08:23:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
 <ZRtztUQvaWV8FgXW@dread.disaster.area>
 <20231003025703.GD21298@frogsfrogsfrogs>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231003025703.GD21298@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0079.eurprd02.prod.outlook.com
 (2603:10a6:208:154::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 914eb809-4e14-4d14-7c29-08dbc3e1a659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WW5AyDbq+Fk5toEAurfuTPJDMTF6s2xYMKEbTkILyOKmmRcVDlDXcdSs0eoJCvznrOo0mR4klLqH/qKfudkf2CH7CDBtkaBeh6WmbWdvLvXBu3bIrwTcRJfppeXLCnZ8F7+nLhnu8JWQe35y1DkoRnLCdWQE5w2Dmi/A7mY6AIE9ZohUva+c4PCY97pqhgD+V1tdROUK24xwBgC0VdDhcHrztKyJEZDWM0in4W/d7FNlrrwqp/xakSlIjlVUSINnJ/Qs7A6WoYzB1wC+AXrDvj2jT5fdsJi/jxyWy8KLMdB4eY/LaHUD2/LYrP4ukc4wMAJVt0K80xrfp1C/l5uPkYq3xUxTk2mZ1z3n+eeI0Hu4tmZSgdHZ/gw0p0TDljNeeAaq3w5DCqWFg3r08h0GcNKOLbSpUM+VXV3WQ6YnsJYiIG3cXTE/Rp2UAlFgyzIwsrUuSK2Jp2jPKWdilbhffFmuR6YLNgpxsU3eMBLyKTOLwqjoD/VlrcOaw/qfRqdrZgx8tV3nonD21SWlcFMAH1dGxuh5w5BjjHk6XQiarwcn9+kCvNm66QDIYpZ0xJeLKwVhTyKssFgXLaD5BwTZB4FT7lOrh6HCn1K2OYHLqP8870skccwXM0XkeQeo/eLeSM9Faow++LRAsWZ9tVCZcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(54906003)(66556008)(66946007)(110136005)(66476007)(316002)(31686004)(5660300002)(8676002)(38100700002)(83380400001)(478600001)(7416002)(86362001)(2906002)(6512007)(8936002)(4326008)(36756003)(6666004)(6486002)(6506007)(31696002)(36916002)(107886003)(26005)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdEdWdrUWdhNzU3dWtrLzlOS2N2ZG1kenh4Z3ZNZk9BbDhpaG5VbmlmZFFZ?=
 =?utf-8?B?QlhYYzhIZEZndEtnY2ZoTnBxT2tjTUlidXdDK09nMTF3WWFQZzViNHZpeFA4?=
 =?utf-8?B?R1NlR3NnN0RMbWxVR0hHQjNjRk1LZEo4K3VoOFVXekFNRmppTnFCQXJmeE5v?=
 =?utf-8?B?clVpNjVGZzROQ0s1Ym5wZEZwVjFRMUxYcjJTdFpBYTMwNmpDVlBZam93Nm1I?=
 =?utf-8?B?NFJELzVmYk1FcTZMUmRGaWI4bDZJKy9XWGhyY0Y3ZTVIdnV0cVVoZmxFRkhS?=
 =?utf-8?B?MlJsbytIYUFYaE1DRnBJL29LRGdYS1djQzZWVGxGb3BSa0NkYS8xbUlxUU16?=
 =?utf-8?B?KzNnSnBXM3J4dUMvRXRFQ0ZmV3NPZkVHRENRY2FBWkVDM1JVNXBZTDN5MURh?=
 =?utf-8?B?RTRadDVZcWZQaHFmdzYrZTdnL3dIZnFXSzRZMnVtSkZlMVVCVVowVFh2dGxF?=
 =?utf-8?B?VVpQdDVITXc4WGI4VlBYdlRhem50NE95NUw3eUFuejNuT2pEdm9DMTVDL1Fo?=
 =?utf-8?B?VVR1YVduZnAvbTZHcHMxZ3JOeHNPanE2WVhidFJyZytLQzhOUzJsTkluLzJO?=
 =?utf-8?B?bERSODE2Z1FsTEZQY1duei9pbWo0TW82TDMwUFRzTXBLanNBZFhiRHNtTEV0?=
 =?utf-8?B?aXlpQVpUTitNajlLWnNYTlJqRG9uc3NYTzY4czlScjhFQUJQNDFtczlDdlJG?=
 =?utf-8?B?K2tzaGJaYW9OQ2pBQlNVS1k0S0ZNMGZRdHByYTl4MGF5Mm1zSm9pTUVpMEZV?=
 =?utf-8?B?T2cvSWVwemI2NWoxdGFJUEkxZjZUdEUwdFpPQ280SzA0alFjbFZnYnRrZXpi?=
 =?utf-8?B?RSs3bUlIbkE5RXpzQ0VEcDVUSlhZV1U0NFA5V3lpckFYdkZXK3RiTURNR2o3?=
 =?utf-8?B?R2FKQ0JCai9oL29tb1VxdVVtTnRqNEpXVDB3Y1ZGdGdlUEFRbi94a01VeUJn?=
 =?utf-8?B?UGNyank1cjRaUWtjRXl5REFYU1djMlJKakZIcEUxRXZrdksyN1BjaDRycC94?=
 =?utf-8?B?WFR1N01ubTY4VitjMDd1QkE3cXhCdHhYMWhJN0JCaXRMSDhKdXR3aUpVRSth?=
 =?utf-8?B?R2pkbUlUY3BHZ3pIczMzbFBUMkpOVUJWcFVENm1FNFJCYnEwbCtGV1N5MEpa?=
 =?utf-8?B?WWNhc1JldU5rZWlXYmx5NGVSNDRjbjFNbmcyeFUvYkdPZnVtVklJdlNCbXJT?=
 =?utf-8?B?Y2Z1SFJPUHg3c3RwakUyZDRkeGhqcHI4cTVsdkNiVFZlVHg2TVBid0Rxa3NB?=
 =?utf-8?B?SHFWT2VoMHZIM3FpSzljSHdmRFdtb0FGY3FCa2lIVjJMYTVjNFpSNkNSZWNt?=
 =?utf-8?B?eXJBakpmbDhwYTk1NnpHVEtNU2JZRnVSUHRwS3ZYWXU3U2FNbGtzMXc0dTNG?=
 =?utf-8?B?WkhsZ0VHQVgrMUpNS1Y2emZNTTd4bkhlQVBPbCtHOUUzbUsrSnlacUc4dUpX?=
 =?utf-8?B?Zng0Zm1tMkdUendZbGxya0srR0hhSzltYTVtZzVZQ2JxZkkxcmczckFnRzhL?=
 =?utf-8?B?V1pwSndQRWJBb3hLL1FZWVJ4eE5LUmFzQlRmZmx0RzVsN1crVkN6a0pLV1VR?=
 =?utf-8?B?WHRWTEw1aVJUUVlVRUNCcXVmNnUzRWZDTWZuZCtKSElNNVNGQ2JXYk4xSFNi?=
 =?utf-8?B?YThnUE5Rd3E1K1ZkOXVpN3RNL3VhOHRtSWdYWVVuWjBXWUpJTXMyUEwyakJs?=
 =?utf-8?B?b09pUFpSNFJqR3BZZ3pqd3lhQTBBWjJlSDFldGJpODdWVFNnaXE3TTFnT3pO?=
 =?utf-8?B?M2NXSHlSNC9HclFlQTNpTGFEN0FaOXF6dk1BZzF1N2xSVlQ4MW1rYjdsV0Fi?=
 =?utf-8?B?aTRtdWJtZ2hVdzJzaUdjckM5VWJEMG16U05YY1IyM1JpN0oyd20yU2YraUZ6?=
 =?utf-8?B?QmN4Wld5WGRZN1NRLy9pMW9wZWxnQ3FmazdwVzROMXlja0doRml6WkxTRERu?=
 =?utf-8?B?V2lFdjhQMVY2ZWlIaGs2dlpidHNndzlKSW40V21hd3NLRStjeWEvTXZrNmUz?=
 =?utf-8?B?c0R2K3IyZmNNQzFTU1BzMTNZUFlaU0ZyRTUyZWpMdFlsRGtHeU1FdEN6Z2tC?=
 =?utf-8?B?dUszb1BKUkxPY2ZBanpIVEt5bzhscDErdUU3U0hWNlBaTVF6L2Z6TU9MR3dD?=
 =?utf-8?Q?6g1rDm/Yn+fzMrhNS7SkwNrz/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3gxaXR1cC9MSG0veldUbmxKaGF5enJlS001L1hkK1dGczFna3JBc08wOXl2?=
 =?utf-8?B?bHM0WnhjZkhDeTU4SHByRjdyeGFZM1dqeEhyclcvY2xTTk5mMC9KSWZCVGhu?=
 =?utf-8?B?ejBEd2w2dGlzcnBDbFFQTVpFdkM5SUc5NHpOMUc5VW16UzBSY25KcDRBUWda?=
 =?utf-8?B?ODdNMVBZbFhqLzZsY3JqSU8rMm5NSktNZTNnUy85Vy95U3l5eVloTkpCVy94?=
 =?utf-8?B?cWxZZzlVaFpsS0QrUzhib2RFN2xqS1RpTzRsUkg2b1A0T2lSb28yRGpOL2lz?=
 =?utf-8?B?WVE1Z0V4djNmb0ZXejYxcEhjdDg5SlJvdThsL2JNcFJzY2k4VmF2cDNLemdQ?=
 =?utf-8?B?NHMxM3FPZzNNRlJrcHJ1ZUhqRTBBNkRFeG1QT0FvdE1IdjZESDN6ajJ0RWRZ?=
 =?utf-8?B?ZnU2VXo1b3ZlMm1UMnNFeDljRVJDbUd4U3Uzb3FCYWlCM01vVGRiM1ArbGRU?=
 =?utf-8?B?NVFnTzUrb3VYbGNhZ2xEcjN6aUFwNVdFdzBoamdSN3NrZWVHemV0WEZjQlZv?=
 =?utf-8?B?Rm8zcnhFdkxrQjIzaUlNZ1dHcDdzUkhIVndla20wcUMrNmFXYTNSeWVjRW1S?=
 =?utf-8?B?MlVEaUttMkxCM1hUcVhscXZUMjh0WkliZDg3Y1pzZ0VtU3ZCWUMzT2gxSy8v?=
 =?utf-8?B?bXlERGJKMk5UQTFvYXFsOUorOHJ5RWtMQ2dWaG8vajU0TUViM2phckRCY2tw?=
 =?utf-8?B?NGdGK05WUnFiZDJJVXFjZkJ1d2RtQng4WEcydzNYamdFMGt1WnVRSFhRVUl4?=
 =?utf-8?B?MG9NbWdtZUxXRXd3Q0JnZ3lTeXBEV1IyVVhkeGllamNENWcrejUxR1JIVUxv?=
 =?utf-8?B?ODRZWG1qaWpLbVQzRGtYK25QRURBOW42S0t3UzZyQlJtT21WUDhVWmZNaTZQ?=
 =?utf-8?B?K3VDZnhuU0VyZVdicFMwaDBiTmVSL3VRcWVjREY4NGxCS2VZTnVZbXp4RVJL?=
 =?utf-8?B?ajM4K3FEY3UySm5rM3F3b0hwNzV6ZTRraW9mdjRKY0hESHFWSWlGekFJRFd1?=
 =?utf-8?B?L1hSRmNES1FHQll2Ymh5UnN4T1Z5Q0gySUk1aVpXSTZOWVdXNWk4b21xeGJz?=
 =?utf-8?B?M1NYRkxnTktsRlJWbjd1Y2YzS20zRmp2eHNXeUNvVXdLTTAzeXZ5UTVtZEtZ?=
 =?utf-8?B?TXErUjBtTmUreUtCeTZBUWJIdFQ0UU1EbU1JUVVsdXhoZEVpaGFkbmxvc2o5?=
 =?utf-8?B?aE5tdEFtUG8xVHZTNFI2ZkdpMFVNK045enkrTUFDaEs0dFBISTVMbUdxNk9s?=
 =?utf-8?B?d2VoQjZGaHVnTnBEc3cyTHpSYW9raWJVRHNEMFVKWUM1U1hraVh0ZWNjbWpY?=
 =?utf-8?B?UjAxc05yWE4wL1drcXBjV2xhTmtXRU8ya1ovcUEyVE5laGszVU4xWWZ3blg2?=
 =?utf-8?B?b01RQldKaE93eTFrbjh4MjFBMzNDczRFRmhuUUppYTlNNVF4RitvdnRGTE9E?=
 =?utf-8?B?S3JiVkl2UERRMG1ZcUJZUUhBZ2lBT1hwTndMdzBlaS8wNWc3SHZGYTBBemdM?=
 =?utf-8?B?T0VGWGtMZ1JYM2xNMlJPVDN3QVRjUXpkR2p2dU0ySjl2UWhKR0l5bWhGaHlZ?=
 =?utf-8?B?VW55Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914eb809-4e14-4d14-7c29-08dbc3e1a659
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:23:33.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sig10BBostLCdskshqwmXTcqC9jJdXNfr4b9S/YmELJGM5TsTPMR9EsMjo9CBOj/do9cz5V7+ySL/iA6+CpBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Proofpoint-GUID: nq005qzl7f0NaT4yotKC08PDvWSHLPgj
X-Proofpoint-ORIG-GUID: nq005qzl7f0NaT4yotKC08PDvWSHLPgj
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 03:57, Darrick J. Wong wrote:
>>>>> +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
>>>>> supports atomic write operations */
>>>> How would this differ from stx_atomic_write_unit_min != 0?
>> Yeah, I suppose that we can just not set this for the case of
>> stx_atomic_write_unit_min == 0.
> Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
> filesystem, file and underlying device support atomic writes when
> the values are non-zero. The whole point of the attribute mask is
> that the caller can check the mask for supported functionality
> without having to read every field in the statx structure to
> determine if the functionality it wants is present.

Sure, but again that would be just checking atomic_write_unit_min_bytes 
or another atomic write block setting as that is the only way to tell 
from the block layer (if atomic writes are supported), so it will be 
something like:

if (request_mask & STATX_WRITE_ATOMIC && 
queue_atomic_write_unit_min_bytes(bdev->bd_queue)) {
     stat->atomic_write_unit_min =
       queue_atomic_write_unit_min_bytes(bdev->bd_queue);
     stat->atomic_write_unit_max =
       queue_atomic_write_unit_max_bytes(bdev->bd_queue);
     stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
     stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
     stat->result_mask |= STATX_WRITE_ATOMIC;
}

Thanks,
John
