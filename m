Return-Path: <linux-fsdevel+bounces-11326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BA852ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052062824C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A122097;
	Tue, 13 Feb 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lsh2QTKl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u84Q+yjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600121340;
	Tue, 13 Feb 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812424; cv=fail; b=k59H5CH0JG9/xiRyf3bCi1JHDPi3nOqXdjg3jRGYxKdbVHO6fznNN7ATp3F6MD76p7SukHDfJdq5GRexHBtrJym1glGjOngNitkGkmPnHp4ISiVRQKk6ihPkW19/JRv/x99DVbn7971RsHasZfpz9ThfZcLFaEYaTLtnM86DuG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812424; c=relaxed/simple;
	bh=rdz2biiAGY6QriwKpJBWUGodcX08PFPpsXrjiZbj1uU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GhWEMO1W6/RV/MN0rupV+IX8sYaKmZUb13dlDTGVpkXPTGd/81+rPhAS0+2qq3iQbfBDAk4bLcVCbxQAcHvsim6S04OWLOJPkBpwpV1fY2aCxQQqI18nJZdwHTZq6Jmp7OHQ3rNqS80/FzOQQGiLHJupg5eb5dZV/wS1h0S/jzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lsh2QTKl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u84Q+yjK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D7xKXE006246;
	Tue, 13 Feb 2024 08:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=83yQsoScOpxPDUppnUPrLDxtLeEzaG9TCaeUCvNC/KY=;
 b=Lsh2QTKlnPmOW8Fk8mZ2cVekSi0YjD2vEmZd8xDLOgAndPVZ7rZ0fFr42H05sVQNDnRy
 rjW5JnzP23/NNdAEi1k9xDhXMJ0t2QQmLE6G4vA5Zuhm0Uu+RyTa7qBh2X/iHmSkfQx0
 k41nchYJgF4AXNggXpsQp4W1bYQe3XtDmz9R6bP1whO9h/0cWDWRrCZgrjgxhHYgcWUf
 F2O38wpoZqAwlppSNf8Uj7mD4IPxL+QpkRmhCxnR2FoS20L2tCJ0H3CnLHkPETfelGHd
 18S8VfO6DJW+b/hidrBuj7UzQouM5t7gkQ+AOffEtksnoGXCGTLCcrJCoLCsq8gY+SQ7 Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w84gx816x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:20:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D89bZZ014943;
	Tue, 13 Feb 2024 08:20:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6qxg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1J0sbjBPY8V2acz//3PTW2KYnV4ahNMC22o4YlIr5eMl8DBGhMOrRCLyJ4FKvC5dFSeG0ufmGvBfhDjXxo6roGuLCLFqIOrRvw3zisiXjoEyhw28NZ4DM7qRVwhi8ydsmGX2/+i+Dj0r+DSIGV/UuKUMvR0Bx+lIcJ+RtlW4QbAchuPmSC15CdCgA7E95Kn/qjv1YR9yGiyCKXRDrsrTBJKS4ohbbzMqVp1xAlAxW3lJdPyINLs8lm82YQPhk6jQsFP5iY7cdThbzKXp+omYMcIc/Gt52D7RhpEBrrN9iZbmldAgNP3EKAiiGDrpv7Nx1ZkWqY/++n+oEzDrBqqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83yQsoScOpxPDUppnUPrLDxtLeEzaG9TCaeUCvNC/KY=;
 b=K3bX2S9jEAQEyGHxVD9ruUHwbvgR/qkNAvGj62N6ubqE0m1HRPmK7aNjSRtGKm4bQZbbB0lCTvbCXNgdKYyU71UsAEMhtWDEJ/BRdfE6SOr20MAgdawu9GVnHkKH4WcWLlCJGwyRcoL+ZVPOvXGsrfqJy2DGKWL1fHd1BRPNWLL7KJCZP3iMb9mrXo8BSg3Y8gLvXSoJpY2uNd4AG3ieHMm/e81mB/H3CPMw0nnI3AUx+x6EPerPOUO4QkWGKfZR9Iwmatgk1Hy+1jUtItcBFe8t8LNj1nwpnE9SYPzwCdaumgYqMIRn6E+q9aADwjAgmj5s+27v17abUw4pcUG5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83yQsoScOpxPDUppnUPrLDxtLeEzaG9TCaeUCvNC/KY=;
 b=u84Q+yjKyJxC/JBWk5QsSjfbAdG4SvUCSJg4mClL7gpmsP5k3hEXEfY08W84o+Glk1QvKN68dkxqnncjzhW/NUR+w/lmMSX2fdjCoK2EhK0hAX2zBTW7gvpf7GcSlgszgvjo3UH4FrMZpDhjq46uuJCM9hiPSzafngQDDDTv+A8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 08:20:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:20:07 +0000
Message-ID: <cf2e7d4b-9ad0-4013-8e5a-48047c588411@oracle.com>
Date: Tue, 13 Feb 2024 08:20:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
 <20240202172513.GZ6226@frogsfrogsfrogs>
 <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
 <20240213065518.GA23539@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213065518.GA23539@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c72f87-0f15-40fa-8ae9-08dc2c6c9681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l8JzSQdwKtsT5R6ply8kY8EVBNuTdg8eN7/SEWE2eNCzLyHCPDIJ1gx+ENL0Ki0RPnCKlLWflUmYJLi8PENxnwEbsxoNduLMCYyI45qJHtKjfa8TlMD4uavfATOxqzVjWqEI7/+2szkOPJjZlVbePBE3ABvfJme4kDj1trM72l+obfrPjpwdjjAQiHjVUIE07zPifRXxxv4o4CcU/H4UXxnUcRbmrFISMTvtBrCzl7a6m/TVs/HvY1kQNHWuBi7cwRU390Ii/5WP/Q2fbfu7p/VnGjU+2SAjmn6TFRy3Z366uqfl1g7xZIaKLBf1jEFpIGxUmn9v+iDt05fK9FNs4UHweeYmBK/BlyPLhSylXn9YCh2P9yE6BFFOitKnFJChXt0ksjxX9YSuJa/TwJ0RC15ueELH96daZEcivi5JwG48TBJmQkj7JrvyNiOomBZF350wH21sBm9BDmZZ502CaMe9307rhA1TzjnWvswvKrsrpptHApnm7a7aYeh7j8hUD65ZqTpVTpyMw4wpUfcjLxi+9y28R3kdKlPImuWWgK/K0/P8S48aw8/FXhy9JzEg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(4744005)(66556008)(66476007)(6916009)(316002)(66946007)(7416002)(6486002)(478600001)(2906002)(6506007)(5660300002)(4326008)(8676002)(8936002)(31696002)(2616005)(36916002)(26005)(53546011)(6512007)(38100700002)(6666004)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2NRRzBJdk1naFJhaE1uQjFDbE9MRHh5TGhSQ2JtYjNkZzBLOGw1cHFmSzRR?=
 =?utf-8?B?M0hvZWZSZ1ZwS0x2RFg4M2pucW03L21nRWE1ZkJYYmNQWmFRNXFPSGdZUDdD?=
 =?utf-8?B?aDRDZXJLZUdqekN5K09ia2hYT0FaOFVuMlFRbVFxeklpc3M0R3R5aTdscmJr?=
 =?utf-8?B?dVBtSlJ0Y1J5MEFKeE5jaE5xTWNCME0yTWJkZ2VoT0oxVW83NTNtMW5zTlpz?=
 =?utf-8?B?andqalI4cmpEN3NjVGZNUDYyQVRaLy9pcmxDWU9BdVlvUHo5ZXRkc2xEelBn?=
 =?utf-8?B?ZUhTa2FOTWdkZFhKV1hYV21Id1NCMFErb3p1TUtidjJ4QVROeTR6UVRaZXFj?=
 =?utf-8?B?YTJOWWMwbUREMnBRV21UNWZTcU11NlpqcnFvdmE2TG5yem1OUXZNTGNCbEJa?=
 =?utf-8?B?K054eW9HL05XV2VEYWhtY2tpUFBQc2lLT2NIcHQzVFdnbkJPZ2hHWWx5dGF3?=
 =?utf-8?B?N3hJR21BWG1KSVBNcFppSnpvajFFNytyOW1qR2JucmR0bEVjSEl1VXFSZGVt?=
 =?utf-8?B?NGsvSW5NSTlYc3FhTHh5cWo1dFJOS1MxdER6akZqWnUwTm9Na1pXRlhLU3E1?=
 =?utf-8?B?WlpnQTg3UzZmT01CVmI3ZVNGYWx4T2E2TkZ6b2gzUFZRYlpUejlsUmtWZklM?=
 =?utf-8?B?Zjh1OFdFb1FiM05FSnlJcDhIVnJ5dlRGTGM3clZQcmQwY1JMY3NuczZCZDlG?=
 =?utf-8?B?QkVTNEJTMlRjUndDMU9YVmFNNFd3d1E5bVZ6VjdMZU5wbkt6UGRLbnZwZjV2?=
 =?utf-8?B?djIwd0N1NWc3c3loQ3VVV05CMnphVFZaYk5qUVlGZ1o4d29kVWVpbDA2U2dq?=
 =?utf-8?B?bmtmSEdLdzZWeGlZekh6ZTFnTHJNTFlYM0R1MW9NVzJYNjFrNzdIZ2JHdE5m?=
 =?utf-8?B?Y2I5OVJVeUtsSFhubk9iUll2ajl4MXlqMDZKWW9XR3dxYmg4RnlMRGZpTURO?=
 =?utf-8?B?b2kzcnBGVVhiZ2p3WXNTaC9wenN4SFViVEFIMEFSUmVneHdjbnpaVXcvS1hM?=
 =?utf-8?B?TmxsVUxPL0xORnhkSkhKQVAvS21NWWNDNjF2N05lTUZOWEM1TTZJQ2UyUi8r?=
 =?utf-8?B?NkxiNzRxS1hENEs2MXMrR3BHNTg0RU0rYWpqWEpBeW9TWGFnRUhvQTZ1RGJl?=
 =?utf-8?B?TUVYQURVT2RMaUZIay9Icll1OU9uemJRWWlLK2FQb2hEcFRHTkRWTXorWXpj?=
 =?utf-8?B?NlNaOHh0ajFqVUpDSm5ubHhuK0NMNGhzMk9UdnVhVStGVURuWFBnN2QyTkhX?=
 =?utf-8?B?TzFmZXRRb0lNai95d2Z4bFIwL0w4c2dPM1RrUitIZWRzYW1ESzVJdkdlNXgx?=
 =?utf-8?B?TWdpaDhidTJxMGhmSXB1b1hIMVpCTzlXMHZjNjJ4eFlRWDdLbVk2K0xYS0hP?=
 =?utf-8?B?aXF0all5aTJ5S1dXd1ZGWkZycDZxUFlRaEo3MmFQc3MwVktnbCtObWczSFlI?=
 =?utf-8?B?bENMU1RwQmo1SnZoUUdndUE5ZWJuS1dJTHh6TDhDc0NQMzE2eFZrcjFvT2Rm?=
 =?utf-8?B?SzhTdURkSTcvdlc5cWRCTWtFdVRFK2syaUtiSG1CbTdtenA3Mk5jRDkxcnYy?=
 =?utf-8?B?U0tJWTBaTmhMcFlvVVdGMXowa0xaUk10VjFqUWxFU2NKS010RDRjS2ZNYmJP?=
 =?utf-8?B?QXpLT0JFaUlwbzdlcnFzRkx3MlNMc1pOeHE4UXZIUmxSLzNkQmF0cnA4Q0w1?=
 =?utf-8?B?ZzFIeTZ6dGRmbjJsRWlwOEcyMEdWUW9CbFV4SUptMkJ4eDVqNUlpVkJTSmFZ?=
 =?utf-8?B?UG0ySUdiK1R2bjJLZHhpbXV0T3pweldRVVlqUEovWVBMRytxRUpHUWZ1eEdT?=
 =?utf-8?B?dXZVM29XdXBiMG9NTGxxNml0NHpDQkp2YzhiTDdoY0ZJVitLSmc5dkIwdEZj?=
 =?utf-8?B?bGFlUUwvazVxVW9aL0YreHh4TXlxVDNVNUtHNWMrQzFCNmZDYStKUVh5TlV6?=
 =?utf-8?B?eXdES2xidnJxYUg4M20yRC83d0NKeE12R3hXVURiVktaS284SEx5MVFZQ2p4?=
 =?utf-8?B?bDVvZzdjdjZrcmxvZUJPbDI0Q0NRbmZuWm1UdmJMQ1dQTDhMYVdyNkNFQ3lx?=
 =?utf-8?B?Wi9GMktKalhhcXFMTk40aERLQ0FRT3ZQUFBZLzhUTFZ6bXpyc0hHQy9TRmds?=
 =?utf-8?Q?QWmUBqzrm5JdCV+GXNzMuV3Rz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q1yDDI9LuNmVo3MJoPL8kaqEuGyPxlnKMZNdVEuSVuBJuHsooOLOHhTvTEadFGcfBHUlesh1DCrzgpGVCGfhystb7YOsyoQhWEgDHwbt6eXnNhvN0gO/q/p48uusSy3ZGzVMhJWsFET0RQBJ3fKa3a1vpWLc1WgaAU7cFQJ+b8cVbLO8lX8i29aVwnvfc98lcqx5X4O/7ko7jX3eo0WSFFlTTmt0UNstzdS59cXq1M8cij4uh0SaFke8TtvFql/NW+aygvuysKNylQV4ZNtuPIz9QfWssASP+vE1roxT3WWKTC5sFxlRgwR43UfCF5BAVHgRy0CuyNc2Mho+WyFmWQrGUkwG98S8QXjIL9gQuI80uKRTkUNGSYCfa+v9pygQJfRqTUSG2ragPvKZ6GGiJ/vbc6EgwM4K8fECCBTCYmYl5m+4WqgcsFjIOJNO4lBB/RSGObz9Y3curVwRbX4FAKDkzm34Hs7D3DQOA0shcs1VZAyNaL30d921rDZtpQC87SKfaNbf9Zfjzxz/mkrhMDiA2O7TIXyqnXZUe93zL2Ums6cZLQ31y1c7TLf8R36b1+cQE2lHSlm7Ysl5NZkILKuCELOKEJdWv16hLYpU3iU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c72f87-0f15-40fa-8ae9-08dc2c6c9681
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:20:07.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOQeVNBvq12I23bC9UPK0AEPMrfn33F/AWtdgtmxjdmH7J2scKtacxh8B7AaXz+99Ogdpxr4tDFNVBC9FA+Tuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=891 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130064
X-Proofpoint-GUID: aRM2pNSMhBWhQfz2T-8jJVYZfYay6ZOa
X-Proofpoint-ORIG-GUID: aRM2pNSMhBWhQfz2T-8jJVYZfYay6ZOa

On 13/02/2024 06:55, Christoph Hellwig wrote:
> On Mon, Feb 05, 2024 at 11:29:57AM +0000, John Garry wrote:
>>> Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC?
>> REQ_ATOMIC will be ignored for REQ_OP_READ. I'm following the same policy
>> as something like RWF_SYNC for a read.
> We've been rather sloppy with these flags in the past, which isn't
> a good thing.  Let's add proper checking for new interfaces.

ok, fine.

Thanks,
John

