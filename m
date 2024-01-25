Return-Path: <linux-fsdevel+bounces-8915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78083C0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066F71C23F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A02CCAD;
	Thu, 25 Jan 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZjcccwtU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q9KYTx0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1D1805A;
	Thu, 25 Jan 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182205; cv=fail; b=teKV+RmGHjFHb6MDNdkqO6igioWgE7r0orII0+bbvzaMDkt2cwAIKZ28TLfeqpIEsWccmTBInRePPkQRbmX8XaiWFFCfYUcLuDbtvyruNSaI3yl9lpXNzmvW3g53JE+A7RoaRi+NutJUOHkRtY9V7XNe5MoIIE042SDo6WjmWKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182205; c=relaxed/simple;
	bh=veijuhf30GlBxCXmo7g2lo/RBMbCzebRh4d8ZtFGIQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHJ/3cpah/qkeZBVj7siB4nmytPZBzInm1QLTo4aZ/8v1mXti2B65f8VgrGFQgPhsT1DUjlEET4RaV6uetMErQWUlwCQMMemt3CWRik0YjUNI8Y7jEYQqlhc12mrGas9qsW+5VmIZ4+6c/rwyyVa9tbHoL8TgHJbdJWxyQf3aJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZjcccwtU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q9KYTx0z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9xbAF011480;
	Thu, 25 Jan 2024 11:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=72RIJI2ldGUFNvEz5ryYwW43y5lQYmoESwnE7/+esVE=;
 b=ZjcccwtU+0Tv36ZVTgx/n5n3rD+1LRBj6tz/4yx1cLzZ9CPgF3vPc8ycgb35YW3vlBd/
 EVTDdBBZosxG3UJISUJDVVZysFDN0yLhYOdCkxscTZbD9+abnEfrOzpliH2wKJZ4RNo8
 5MEF/qv088WpD0U0uzInAtg1ua9E0DynFszx3RejiwBTzPadvT9R3hyFAwzHUqFQ3gxz
 qtvWLb2vN4IzNZ4E4JfcktrvPpwJcPJOqHD/5uj2hKT9KqJiuezQBqfCA/bKhegscI3M
 52HwIn7UrbIqSPV5jg9Bw6CKeqxEqUy1/6FK8zGzeFlbjvJ/Yjf7Cp3SdBjW/dw9nJP9 DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuxw6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 11:28:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PA4m93014166;
	Thu, 25 Jan 2024 11:28:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs37485dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 11:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnySUv/XWddDeAf33C47E6jDzSh9T8h3QYwarQdMPtaz5/aXHiCML6BfXlXteoATWzk+2kNBO0VCMfCNdPYksVYhKa79046eDgV5w28aF1gd2jSG6541XKz9dfwQ2zf0bHvTeo4/sqKJEQC+Aqog8rQi0YlVZ4h6z8ZxQz1wLY0ecSEMJO/t/nUfLkACSFR1Tk+lYy9ygnywRX3JXqv384BiO8JSlLsurdXrAXJLijcYky44+jrmGETzzj2L/HZ8vwWu0fGuujkoXujeC9HfHjcZhP/tIUUC4AdnWwvr7aseXVI8SkFqlF7T8yGNPl1TOkGKQzr3fY9AvXqrT4Gh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72RIJI2ldGUFNvEz5ryYwW43y5lQYmoESwnE7/+esVE=;
 b=Eb5vH7ppqEBsMjHyTVHyxs/mJp147Bx6zcoHalCfo4nacpVkmd1PCLVC8WrNLTBwvD245gEBDMqDRQLUreOk5Cvhyg7X++L63D4njkLliQ2hbsdSfds/lvXWmTqxULz9mQ/mn0YfrQmqlmkhbWzOe13LkmhlnmsLwNOOuobc2Ie6a2WvKbLEkgMbuPmR+hkQM7mLEyVvhLXhBcZD9bR1ak7iMWj6JU+BXbnI3yySN3DNPXNEd6mnunYHO3DiZv2hfCvuPhY9JiXNMRnrAkfRIETGu8qEEu5YZ2MMvEzgD9OFjrIt7RE6/nUrr0wY0V3wpLa9jm6SxGLb8bRqVylfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72RIJI2ldGUFNvEz5ryYwW43y5lQYmoESwnE7/+esVE=;
 b=Q9KYTx0z7czixxSZf1zcpFKlu/Uyi/oEB6B8O5bb0O/uEvqR5c3S4YOGVU2B/vjIWXL5VMq1hzmpfHhimSs4ywlmuXSpoGlMeR2fn6+TKiquTrRAtzyEACqp8PAr8RhjIOtOCCO3tcYLhK5XYZ/xzhax6U7ssHOG0CZz2k+6gdE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5228.namprd10.prod.outlook.com (2603:10b6:610:db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 11:28:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 11:28:27 +0000
Message-ID: <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com>
Date: Thu, 25 Jan 2024 11:28:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-16-john.g.garry@oracle.com>
 <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0468.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 08212471-e8af-4c64-68e4-08dc1d98bff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ghgt0XV0RzHx6O5KX9PC2XAcjl5siktVweJYUeRbm9zUN+7RF/F7CHnfYNVHZY6+rPGDMhQoJsxX/N6HA16EkNLXjSyxSYXYdHxqwuYQubTWu2g65ttzYGJpfY9N5C8+YoXkFvAlvdOI9JJnHhxRqx2NOxbAp4kB7koIQRcj7uIGAttOMLmYQFEalDwu4hllMjXABWm4KbqxzilD23Mo+/XbIUmwqy1B8W+5tZ25Lgg5pShdG4ggXD3Gfdizl0F4c9UeGMbzmHCI1p6EXqPxxV3qK1R42SwyrmFJjluJgHNjNtffzBBx1E3t3d7gAGYMInXvzBHBa6Oe2csVh6KhkdNlEYV/ZOjOAiWITZ2h3SnJ65XYuaBAMyf+nySj6QEyskNfxjGf3K81q04gl7JlJmILPXO/7xByLBkyDuaHCdmZ50egTpzqI2+PgdKNQTZJ0QlZ5Xl+NHWj/V9duE23qsfg/vQiAMgrO7JXwFimrc4ME8aY2Y6hvU/8+IClts65sJS5EkujxBn+2Xr9zfI3d7+ouio3zy0WJnu8yBTOcddbKQoWbD+oyEY/EojPVLpFDPzshigc+MLzTwOjiy01ebxNTJ1l/SxgO9QpQTa9Cxd+BLXCOgKdKTHYVi71lpIUam9dLie7vMVYqP+FydKYPAQ+Wb715lT26y9wfJU422iM+EKPk5fB/kv+AzpIPKft
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(966005)(66556008)(66476007)(66946007)(316002)(6916009)(36756003)(5660300002)(31696002)(86362001)(41300700001)(6512007)(6506007)(53546011)(6666004)(36916002)(107886003)(83380400001)(2906002)(7416002)(26005)(38100700002)(2616005)(478600001)(4326008)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkUweFVKMTgxeDZMaktFelhaUjViT09SdGRvbG02UWZMeEJ3N2NjbC9iVlFr?=
 =?utf-8?B?MlpzWEJsdW85dDl2QlNUQmNnNk11blNQZHp3TGxhdDl2a2ZydGR1R0RFS3Y3?=
 =?utf-8?B?cnN2SU91QXQybFZjbVdDNWhIZGZjbzdGWlViOFMrZng2bE5GcEdsOC9McURj?=
 =?utf-8?B?TkZ4VVEzTzBWdkQ3MnBySGprK0NYWmlwcDFRMFJVSlRtbnNjL2xwellCVlBz?=
 =?utf-8?B?OWNCWUV2eDI1NFUyNXRQTU1PNm93bXN2OWJQd3FzN0xvbGJWeHJQNjZnbytV?=
 =?utf-8?B?NHRUYk91akIzbmtqazRuWktlOW1OcnVVa3BQRXYxWkFrMXpCcGcrV0hiTFhF?=
 =?utf-8?B?ZnVEcmx2TFQ4WmV4alJVbTZRYjVjZ21hV1hnWVZLKzEzYTkxLytzZnZLUDFw?=
 =?utf-8?B?UWxRZjFIQlZjUk92eVlMazBhVDRTTWlLYXdxTWNOZk0xYnpENDBsUVdSUnRD?=
 =?utf-8?B?eWJCcDEwWWtmczBvUHdnUm82eU9oWUJsUXBHTVRQQXlJT3ppd1JqL3dkVHd3?=
 =?utf-8?B?UzlMWTZVb1ZTWFJVZWREM0s5REpZTURxNmhRc1VoTmc3aGhMM2pHaTdyWXVr?=
 =?utf-8?B?V0xvTEhBR2V4OStsWGhxUUpPSzVZNUpCc1dOZTljc2EwSmh6cGdQbGJ1YlVJ?=
 =?utf-8?B?UG9LdmVmcjdLM3Bpdld4Rk1Ha3JUaVZMZ1ljcStCTUo5TVdSSmRYVVVnY09J?=
 =?utf-8?B?dHNrQUNocDFRWFkyTnJtSjdpd1NjNXBLK0NiNS9ucndEZGZ4SUdBaGdtTUUr?=
 =?utf-8?B?bnBiOVVOd1J5WDFHZXNpWlZjY1ppUFMxRlN2a0s0ZWQ2MmxUWlh1ai94SFlO?=
 =?utf-8?B?OHVNb2QyUWp0ZVNsY2NJNXNjTDZlc04rRExTbGF2ZzRMVUhWM1paSEpqU2li?=
 =?utf-8?B?UUM3RUdRNUFBTWpqc3lkd2IrZjhXRjFTWTZxcW81Zlk3V3lKM1JxaE9sWHMx?=
 =?utf-8?B?cTB1d1lHait3U3BDTTVCeGJCRHAzWCtjT1ZjRjh3NCsrck1CNHpNWmhPUUg5?=
 =?utf-8?B?MTNZYnJuWHZGS2FjcHVXMDVVdklIR3p4RGFzREo1bmVjVkNvSjFPMnpoUC8y?=
 =?utf-8?B?S0hXWGJQdmUwVUcyUGlLZUlzaUxDQStYajA5aVA4NWVYUWNDUjZZMWhkUGZJ?=
 =?utf-8?B?SkUybmxJY3BQMi9hZlZvMVJaczl6cWJFTWloaG44TjVYamIydkt6eDM3dXE3?=
 =?utf-8?B?dklPcUllemxRYXB5K3FWdXBpN2RWR3Jud1pjbURtVXBlSStHZUtRWmFHSW0r?=
 =?utf-8?B?em5adVJESWxHTHl1YlFSeUd1U3RqTUN0UHFhL2N5OGlERlVkVkJaYTJUWUQ5?=
 =?utf-8?B?eDhwRHpVc1RHWW1wSFpUeDE4czVhV1RkaC8yTzZmK29DVTdMcjlnMi9uMVlu?=
 =?utf-8?B?YldQUk5oSlpsWFdjZ2lxUnpaMll5Rm1Kc2M1Wi90OVRLZ1RZc09QaTdHL2JE?=
 =?utf-8?B?cEliR1ZEb2dwWm9YRWl6UTMzN3cyTHRiQ3VhOFhQUmZsS0syNmFRWk1BZ044?=
 =?utf-8?B?SEhQYXJOdk9CMGpna00vMEdGOFV5UTdQVUpQdEZkOVNnMWRzdzQwQ2lSUHNu?=
 =?utf-8?B?ZVRENDV1M0ZDRk43ZzMwRVVVeEdhYTRpWVRnSzd0d2RhWGh0eUhSSFA3QTVC?=
 =?utf-8?B?c2xwbmlkRmpwbGZoTkdlUjU0L0hUYzNwNW1OeGxudUw2RVYzcDF1ZHZTZm1Z?=
 =?utf-8?B?N1IydmJJS2hNaDB6ZUJyNytpLzhvcEs5dVQ2VjBCUVQ1ejBhQlNPdVA0eDBO?=
 =?utf-8?B?OUFSd1VRVzNqdHE3Y21KdGhUT0ZIYTJNWHd4RHFEVlIyR2czalRiaTE3Vldn?=
 =?utf-8?B?YWlEenoxNUp0Nk5heklsR2hSRWxGWkxwc1R4Z2Fmc0ttWXk4ODd1Q1EzbkJZ?=
 =?utf-8?B?YlRDbmtyaFdFaktoWFJLNDlNSTc0dThrMlBTdnQ0dzZ5UWdJZjJvbkhXbloz?=
 =?utf-8?B?bzcxQURhV0dYdlVCMWJGYnRhTVlkRVpHdythTEdKNnRFTVl1Y290YkxJUFg2?=
 =?utf-8?B?aElCOHRMenVGRDI5TldDWEwvallkQlU1bGVIcG1qMW54NEsraW5YTlhDamo2?=
 =?utf-8?B?WkNORnJnUU1RaHljTWtPUjdPZDRSYTJUWmJiYkhSdXMwSnBoSlJITnBqV0lh?=
 =?utf-8?B?NE0xcDRScXZON1R3VXlrN2RnaTZ6UGs0T1MwN0pzOGk1Y3NMRnJjaUE1OEdX?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	km8xrar7MaX8dXRhnKNX0qkPqCjhUBGOvvU13F0kKkvS6AU5BzlNCGv/fLnkYtOYbRJr1ZKg0e1Kd8kMhiCiT3Lanipsh0fJZGitdym8YUXrALfgbSjybFP55rYgznIKKXgidRBGU+iitnSr5D4oAveEzv4gkzVY5iLpGvcpCAWjYbRVatMEH2vPvih3zoWl5QawkmMjQ8RnWt0275THeq1j1atI+UPP6WWwhI3bC1bnoK13ImN8L9DU/GfANuwWMjBVHNYNME4TrnnM64sAKZaaliRwp/1+V1dAbAy3IajC4yvi6c4w+CaOr44A+x5pr2b17Q4E8ZtZeJ15/kewAgFsrghVEGK0frMutKccv+W5Hvz1UN4w8F6puARc/kx7CgSYqnIqapuM0ryIlIM7pCoi/CmS3FK63qMSyInB9kA9ee/sf9RsT8ZaSYpgfdNbYHmeCLxz2AngdrBiLCr1VWwyCD1IlPEZsiG4hSGOHUPAVm8RqjZ5s21uyGcJSOaTqP7R+VVtREUamUUCwcXk//DFk25OmVOhuAtK9Q/Yo6bolL+gfO6QneWI/A3hD0hQ6pnca4yCBZUEX8T+pvC09uKenxdKl0jU4YBd3ChCwD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08212471-e8af-4c64-68e4-08dc1d98bff0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:28:27.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfTf321zi9u/wGdJFLBY/t5Cc6NCgES0nkofGXBtyyeo4HwgAjKgdvHCJmu06PpqkwhLQNWjdo7V5o3z2TPAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250079
X-Proofpoint-ORIG-GUID: Vf1iq_2r6zqSGZHGc0SvAfDZcsgz2DEJ
X-Proofpoint-GUID: Vf1iq_2r6zqSGZHGc0SvAfDZcsgz2DEJ

On 25/01/2024 00:52, Keith Busch wrote:
> On Wed, Jan 24, 2024 at 11:38:41AM +0000, John Garry wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 5045c84f2516..6a34a5d92088 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -911,6 +911,32 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>>   	if (req->cmd_flags & REQ_RAHEAD)
>>   		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>>   
>> +	/*
>> +	 * Ensure that nothing has been sent which cannot be executed
>> +	 * atomically.
>> +	 */
>> +	if (req->cmd_flags & REQ_ATOMIC) {
>> +		struct nvme_ns_head *head = ns->head;
>> +		u32 boundary_bytes = head->atomic_boundary;
>> +
>> +		if (blk_rq_bytes(req) > ns->head->atomic_max)
>> +			return BLK_STS_IOERR;
>> +
>> +		if (boundary_bytes) {
>> +			u32 mask = boundary_bytes - 1, imask = ~mask;
>> +			u32 start = blk_rq_pos(req) << SECTOR_SHIFT;
>> +			u32 end = start + blk_rq_bytes(req);
>> +
>> +			if (blk_rq_bytes(req) > boundary_bytes)
>> +				return BLK_STS_IOERR;
>> +
>> +			if (((start & imask) != (end & imask)) &&
>> +			    (end & mask)) {
>> +				return BLK_STS_IOERR;
>> +			}
>> +		}
>> +	}
> Aren't these new fields, atomic_max and atomic_boundary, duplicates of
> the equivalent queue limits? Let's just use the queue limits instead.

I was making a copy of these limits in the driver out of an abundance of 
caution. I suppose the atomic_max and atomic_boundary values won't be 
modified in the block layer, so I could use them instead.

> 
> And couldn't we generically validate the constraints are not violated in
> submit_bio_noacct() instead of doing that in the low level driver? The
> driver assumes all other requests are already sanity checked, so I don't
> think we should change the responsibility for that just for this flag.

As a safety mechanism, we want to ensure the complete stack is not 
giving us out-of-limits atomic writes.

We have limits checks in XFS iomap and fops.c, but we would also want to 
ensure that the the block layer is not doing anything it shouldn't be 
doing after submit_bio_noacct(), like merging atomic write BIOs which 
straddle a boundary or exceed atomic_max (if there were any merging).

The SCSI standard already has provision for error'ing an atomic write 
command which exceeds the target atomic write capabilities, while NVMe 
doesn't.

BTW, Christoph did mention that he would like to see this:
https://lore.kernel.org/linux-nvme/20231109153603.GA2188@lst.de/

Thanks,
John


