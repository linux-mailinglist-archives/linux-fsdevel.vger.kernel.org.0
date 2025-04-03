Return-Path: <linux-fsdevel+bounces-45656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1BEA7A5F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591633A7498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F12250BF1;
	Thu,  3 Apr 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fJ+1eEn7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GQ7oKGuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C378288A2;
	Thu,  3 Apr 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692842; cv=fail; b=kckse2k7bgD6vbQPDrZNCuoNVH3qC0BfkjDHrnF7cQdXf5m2VsEmxT/XHT0l5aIsTnZk99K3IhUSnoJz9zuvDpmEiPlfMT/ckC3daJfMlW1bxs7rPOqnbqb7DQ9X2NHkf69XEB0AivBfFET/xanvN9agCVuXZO9IYHTGw3vJXmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692842; c=relaxed/simple;
	bh=gSm/hzgX0nBGM3rBWnVLGPkYbArMVk5NmVWgD+8zwH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CxN7u4arHfVCK2IB80rJAXlZEfmNO3kLZpKA0JFyaXtqQv5ZGzSgufiT74WpLhZOKjYm8a0mgkVlrD3J63okdnqzVBJnDDkBMd/FtpfOkhHE5jmXnEWvKGBNchmhsvzf8OlT+lm3+mNm1cUQm37N1PxtJ3D7U7qSSDTXNFBXlJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fJ+1eEn7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GQ7oKGuJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533BHkqP022356;
	Thu, 3 Apr 2025 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EoWF7DZEiIRvPt71LG0hlR1zHiS/RJ7eHM8bHPiqbcU=; b=
	fJ+1eEn715nfRrGdW3nng5Jg+4llgG0pq9sqVFLoAFn/CIKazdVPYApN+tJP7QOn
	ffgG7toRyttrMMudkazQ8PxL2Oa1nygtF35DJk6qF4Bs7Lk51w4XaLY4Rle1ubjZ
	Y/YhZuZ6mZLelGkDx0TefPCOW0jZX84pW1L6lIYqlG8vcNOy9iKX9xKTu+EpdVML
	JxCTipL9CCj5vPgSJy8D2J5T8HRfI8E6sCyyHVg8PWRZPAPp8HDmMyLDARtryQ/4
	HDYbJapZDvMWeAU2Cwfe0OeJsTi/2m3k/Zkuqj2O5egqhH2XAeOtOPMwY92mNIfQ
	0bE7dBqK+YNCWwgvQzM0hQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcnjae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 15:07:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 533EPv1p004285;
	Thu, 3 Apr 2025 15:07:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7achjcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 15:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZcsCgIIafR3sdLFpSSy+3pGw0VzPjvGK/7e5WSUEjVBMUaT8hlecdbWyJSFNS5EpnhbRdKfqeCjg7UIjoeU0pwoBPMc9iyHzweGLUMm2HM9OFgp0s0uCEf3nF1OdptwmO5Bpjv2powWpHmiJ+0S84l9P2O8KWUquNyJafCvfwolOrYM259VqN1kO9B6NhvG7hRD4OUFdaFAkmny/U5qpEMG6WR0gmmeiPu4d3j2fen/PuxyjfIRq7kCqKDIWNtMjuZY38zPDWRprVIw50sLTgZf/jsrx/+AD7dYBadrdkMx8A10ksfwBc0N6881nhk8XU9nkxv6LzRT3J8syq/hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoWF7DZEiIRvPt71LG0hlR1zHiS/RJ7eHM8bHPiqbcU=;
 b=GTqZQ5WucDo0NiuHYhIgvDM7FdRTDxXM2v/Gq0fktkYGz+BZ1Fo4LhVJ0USiiU45QiDr5WFoRWUSXkbw95jl6ZTIOR9mRw8JauqMGsveUNTndIZSuAzWRrPnVMN4bIbVkhxhrKI29xY3MHZXOuJzQKXygRMY7Ku7lN20p7PMDA16J+KG6UQlO53lNeE/MnJrFCSQFuk4h1ThklECLjFEquTChpq82SE4spR5ea1/RzGj8yd2scPu5cdE7helnNO9QTlrduqRN0vdy15Ro/IRFv/KI9Q32yHNfj9SJRNoRnq4nu6/FqGNeoyFA3P6pa9pqiOmaSabrHmay74zCc3zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoWF7DZEiIRvPt71LG0hlR1zHiS/RJ7eHM8bHPiqbcU=;
 b=GQ7oKGuJtWnZnLVzYdvaQYkC+h+wW/aL40F9/HRsgO+V/kOUoJMs4zX/iPq+Mo4MXrkQ5VFZyNCSwWUKcg8Lt9iZ5MGh7nNioie1DebN7/dYXXXtcl3BSoZmrc7klgaXqVoTqW9XdSU0N+dVnjU798IOcJ8s3Wx4pye1YNFaWn0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 15:07:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 15:07:08 +0000
Message-ID: <5485c1ad-8a20-40bc-aa75-68b820de5e1c@oracle.com>
Date: Thu, 3 Apr 2025 16:07:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
To: Christoph Hellwig <hch@lst.de>
Cc: alx@kernel.org, brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-api@vger.kernel.org
References: <20250319114402.3757248-1-john.g.garry@oracle.com>
 <20250320070048.GA14099@lst.de>
 <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
 <20250320141200.GC10939@lst.de>
 <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com>
 <20250323064029.GA30848@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250323064029.GA30848@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b1db86-1e03-490a-bf75-08dd72c133ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEp2ZlpveUpocTY4MjFqVU9UaUhpS0NiMFR4ZmVSaEhxRkFEY3RuMnZnWlg4?=
 =?utf-8?B?NmZxcVpQSndMYUZoSU50NDhpL201cXRZN296TmhneFhoRTlnYmxRNXZyQWdr?=
 =?utf-8?B?cFhaNmU2anIxNm1oNzhuVUtDSFVtV0FTVnpaWVBPUGEzUjJYcEt2a3RJU1FW?=
 =?utf-8?B?S0dRYjFPRnFGYTlidWV5T0pmOTZCd0NJenR2a1R3NCtmUkZpNDJqaTFXQTRr?=
 =?utf-8?B?czFDRjIvYWEyc1phckY0WTNhUjA1aWpCYmh5VFUxQ2RYSjlwd1BxMjEybFNX?=
 =?utf-8?B?aE5kSGhUTW1GS3VBZXVXRzVtMHpobVYzUEFZeGNwVUMzVW9EK1pGOHdaTkNk?=
 =?utf-8?B?bGUvc1NWYVBaVVBCeEt4bE1rUk0rK24rbG9xTlFQZWVKU1YrUGI1NmkwM1kx?=
 =?utf-8?B?Z2ZZa3lYN1J0dTl2V3lFYm1naVFyeU1BRFlCRUxBSmNFNEcyWjNSZ01RRC9u?=
 =?utf-8?B?Y0VyWFhHMlpWaFNBanFhUjk3b3QvK0xvb2ppMTZ3bXVjQXRldWhKMlROcGxC?=
 =?utf-8?B?OUl4Z1dMK1J4dTNha3JWcnVnaFQwN1dCMlBVRFJGTHI3SHc3UFRLbnlXSE1m?=
 =?utf-8?B?aTZPaXZ4TFFUM0Z1RGxIdUVkMFRpSU1BUWVFZmNqZjdCbkhFVVl2dnMwYzdH?=
 =?utf-8?B?RUlBVHRVU1AySGt4NEtqS3lGaGliejRLOWNaQ3cwallYWEZNL1ljM0JZU1FD?=
 =?utf-8?B?Y2tabkZuNnIwZmVEYkx5NEFxaWwwNElBSitLbEJxcnNpSWsyZTc5U2ZoYTFM?=
 =?utf-8?B?QUxLbSsvWnQ4RlV2VnE0Tm1GZ2xrbWpqczdUd01pL3IxVG4xT0pJdVMrTnI1?=
 =?utf-8?B?TUdtREYzMDFMRWk1clhWSjNFNUNoc0wvVlFoTjhzY3dWUFhuaWR4NzhLdVRI?=
 =?utf-8?B?UEs3ZjIvUXBDNWMwaFhQL3NzcTRkV25STEhvS0VhcnZPa2JwSXhLSzM5WEJu?=
 =?utf-8?B?WGlic2VUeURteVF6ZW1lY01KMDNaUEhmRXlMVzJxN3ZtOUEvdUo2QXAwMHNY?=
 =?utf-8?B?Yk12TWR6RkFDSCt0aDNvTU54OSt3WjdWKzBneGVPdjRtQ3JMU0drRHNnQ3dZ?=
 =?utf-8?B?Qld3WE4wN0RKcDc1ZUJ1TmFScldORU9TVTg0U0NCMW9ETStvZWduYjJYQWR0?=
 =?utf-8?B?QkYyWENTbndYUC9LMTV2Rjd1ZXdkR2VmdFlvUVAyM2FjR0NQclY4MDMyeVFM?=
 =?utf-8?B?c2p5SHVPeFYrTjlZVndsdGd5MGhTY0JwQTRiK3VIQUxDUDhZRmMwbEh6bmxl?=
 =?utf-8?B?aExNRkhGelJObmtlQWtOSWFKOFZmOVAydDNFWVBJTU5DRFhYU202ZWsrSXBR?=
 =?utf-8?B?R0IwUjRXWHNESmE4WVVYNnd4TWFaZXhxUlJzUHVJRnlkN05ZbFN2MkJ2OGZk?=
 =?utf-8?B?UndvUTZTVnB5bURLT3czZWJIN3FiL3NzN1g1UEdoNkNIN2lOZzhOLy9IV000?=
 =?utf-8?B?R044SDBabDVnVk5zN1FiSXdkN2NCbUlPR24rUTdtdTFFTXlIRGZVTnZncU83?=
 =?utf-8?B?UldSK0hQSTRXUjNxa282cVQ2aHpUb1dNM2pFQUJRREJGYW12K0VsMEJFR3ZH?=
 =?utf-8?B?WUdrQlNJRm5NT2tjaVVZZGFaekJLTytUR253eXBiTE5jOVNteDdNbUZ4M3Ju?=
 =?utf-8?B?Zld0WFhjVEwvWW5HbFM5ZVBSTWJ5LzZtVTFHNVE5blpzZ2RXaThhL25SYVBr?=
 =?utf-8?B?ek01VDd2bjZLVWFkaGhIYklaUVdSM2QxLzJhaVJ0S3ZsMUFEN0NlUWgyc3BO?=
 =?utf-8?B?V1pYUnVidk5yNFl3M29oYkhwWGZMSHBxZStIWUVna0prVnlrbkluN0FMK2Z2?=
 =?utf-8?B?eWtHaWVCNE9Jd21WQzBZcDMvWUd5WUxLaHVlaGVuYS9pUXdhaVdWeVFPMWln?=
 =?utf-8?B?a282U1lKeElQcnpCZTlkVzNVdk5xSkIyeG9MT2lTU1VmZ0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDZzVU8xTVYyaGlXV0VFNEJWakIvd0p6dVE0MTUvREdsWVYvSEpnYVUxV3Qy?=
 =?utf-8?B?OHhWTzdneWxGektQL3YrdnhaUDdXa2pJamlCWVQrTzVMalpyN2dVdEV2TmxI?=
 =?utf-8?B?Z0RsMHJwenJ4VG9CM295aG5mQ0RFajNXT3J1bTVkeTRseDB3SWNibzY3QzdJ?=
 =?utf-8?B?eFVDRGQxWTlKR2MwU1BGQXEyaDRMNkVhVTFIOEdycTh5QTFjOC8xNG1BOWVa?=
 =?utf-8?B?NCtMV20zemt1NmNzemtldUJYeGpSZHFwR0lETHI1Q3FyeGpCblZqNWhkZFEw?=
 =?utf-8?B?ZHdHdjRaQ3dPenlKbU56NTUzRHRNMHY0Ym83Y0xjb29wTUFJMkI2VlYrdjlH?=
 =?utf-8?B?RDl6aHZDMXlOdWFaWUlwK3NvUmNYTVlHM1pmck1mL2NHRGdORVA5cC9hd3lM?=
 =?utf-8?B?MzdRVDZTMjh0WFpUSnVCZ1lQTjkvNWNVQ2VpdlRJTjZ0RWZ4ZlEwWlY1MVFo?=
 =?utf-8?B?eFcxMDZ0U0wwVzJuWXo1ZVYrM3dKS3Q0ZFViR2VuTWxod3ZzTzE3czBXUk5V?=
 =?utf-8?B?SXozUktBMEdpaUxWRmxtVndSazVjSFhGVlcwTmMxaUJQTjNubUhmWmV4Qncz?=
 =?utf-8?B?Nnh4TFF4WTB2TzROQXBxa2p3VTgwTXBuRmM5SzBxTmhyWmpsYTZ4THYrZjBo?=
 =?utf-8?B?enkwQ0tpNWhEZXZXdmN2aWJRWGpTdUNYOWxoN3FVNytmdjJjYTFEYjJOWXox?=
 =?utf-8?B?UHg0eXAvTW8xZWpNZ2E1bWdYOGNVcEVxSklDVi8rekZMVW9ZOHBRVWtVdlNG?=
 =?utf-8?B?c0RjKzhNVTdZanEwNlRzeEgwdEN0TFNhZFBRelhVcDdQdGdWVFJLb2h3eDJk?=
 =?utf-8?B?d1B6bkhxWEROOHF0S25xS0pONkRUc2Z6STJ1VWJ2T0JVWWRFUHJKVlUrY1pp?=
 =?utf-8?B?ajc2aEJzQTh0ZE5NZGM0VXB0NnBoMTBIU2gzMDNNanB5U3JPeURyemNRSUtJ?=
 =?utf-8?B?TWJubXoyN0gvQ0ZFOTE4aWN5Mk10VEhOUXNrZnAyK1EyTzNpZGcwQlJGVER4?=
 =?utf-8?B?Z3FCOWh1dHVsbkNkUjdXdVJzR0tDbGsxVFBRelduQkJ1cmVJSVdJQnNxVm16?=
 =?utf-8?B?YVoybjJSaDI1RFZCSE5maUxRTWU2bDZqbEpQUTlEcjd5c1k2eGhQSkhoNTZF?=
 =?utf-8?B?N0VNVFNsMGRNVkovaDVGd1hyaGVHa1lxcVhkcUY3RlYrNXVvWGt0enArNXRZ?=
 =?utf-8?B?dW9OeXloUWtYSE8xcE9yVFNNODhic2QrWC9iTmdEY1ZrVVF2c0tuS0FpdCtI?=
 =?utf-8?B?Yko5K2pZVXpNRVdNU2NPNFFRSGk0R1JMS3FuQmpmNEJQNDlYN1JzcUd5M1U0?=
 =?utf-8?B?d3U4UU5uczBSQ1ZWYk0xekdBOVludGsyaFpDd0lBMFZwT1h4L0NOaStQek1S?=
 =?utf-8?B?cGFScFVxRWoxQ1hFakh3SVFqMEtBL1A5YVFmWE1HcDlyZ2sxcklmUHZoc1Ar?=
 =?utf-8?B?YVpPanJNMk40OUZZa2V3eTFwTlVwcUhwd2NQZDJlS3NJaXY2V245dVBPNWRx?=
 =?utf-8?B?NGpBYWRteTVnUFRybHlCNnlxQ0ljVlRYZkdiUGJGMGgwZ0NsUktEOWttNmpl?=
 =?utf-8?B?cW5iSjlPaGJsSkMvMVFlRnU1VTdpNVZ2by9yMVU0Skp3eHlIR3VkUXpvRUVW?=
 =?utf-8?B?cThxK2ozb1ZmU1FkOU9RQXdPc3FWbjZWQzROQzRpK21UR2paUmNJazJzZXpR?=
 =?utf-8?B?ZzgyL3dxakNzSGUxOUZvWlk2eFNJMTZaLzJXUHFFbW44VXpJTzc0K1dQb1pn?=
 =?utf-8?B?TEluMVFybTVHT1V3SDBVZytyOEN3NGxSN2FKcFJ0QVREMW9XUkh1QUwrV3c0?=
 =?utf-8?B?WUplTDI4SWVNbjVjNG83RTRSb1BXSzhjSzhwY0x0ZWJITkRKMDVPcVRwa2dJ?=
 =?utf-8?B?VCtLS3VsdUgyQkZyekxGbHBIRk9jRlJLdC9rdUpCTzA1R0szZzJhcThVZTll?=
 =?utf-8?B?QWN4ZkU4N1N1N1Z4NkxvWGFQVTB0aFBpcXpiVlFycEV1ZmpYaEtOTC9EQUtk?=
 =?utf-8?B?dFZ3Mjg3cWxJd3FXOTNKVnFxQkszd05CZVFlVjdDZTJxWXQyU0tSR1E4eVFF?=
 =?utf-8?B?NDBETXRqMFhXTVB5Myt2WnJraGNrVks3WEJ3UmpRbE9FUHZiVHE3Tmo1bEFu?=
 =?utf-8?Q?gqXUsUVsHXBXrxMIs3lpfbmME?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pIfBXAGQbV0gJB/kikIcid68DdJ8xf9OYKVLEFJQQDxdAVK+CDWCzp5pUnNYbyJgPVNSzgZhsznhh44x2Y1/8mdYyV9OQdlrHt1f1ZKJKpZav6RRGOKAMbNHN6WtUznjPLh38dNS0pglm4zoMsU8i11Bm8WEYwhnrGPoxcf7LbeMyXv5ftzbnfApNquk4VD9LoRKTXPoEXamAOj4prPMOqk4s0QoQp2rb/D7vOsXSqgRLQIffFR+IV2psmURwet8p6I05g142Db9Yel8MwubocQmfGIlyfoh2eC3Uch04J0578ZcOf2hTie5DqrHxkYb/59IaDoHyGe9k/611kYbhteIXwcmfJc4Y5QWlkmBh1XVDOfLV/Xhlx6QWijdN6jbGEp+oGlHS79DA3M+JUcQ6m1iFEb1o+ZJLKooKwhpZ6IZr9KhMjsm/UruK1bYTXkY88/4O73MpGcRtB44+yIkfO3exniQ9Fv8cKg2K1vxfYuyz/RhnK53i+6YWUV+H4D+z1fE1UtYtIq2d0xO6NPHmZtU5nsTPwSmLaQb74IPPaOWEamhtRr6F3Ezn8KRpL+tdQuCf0qGHV4HHdlab3WykM6t75d77PFozKICjsyHpy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b1db86-1e03-490a-bf75-08dd72c133ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 15:07:08.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8D0C3fFLbFwVkQG/+S+fVHDzxzUbYB3Kq17TbPpAcQQ0oQLn/+IgW5xUvR8SMXgFaEu+4yJuVQ5tWSHHsea9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504030072
X-Proofpoint-GUID: pd51orVMwp43FFhprKIn2vSEBAwxFsHd
X-Proofpoint-ORIG-GUID: pd51orVMwp43FFhprKIn2vSEBAwxFsHd

On 23/03/2025 06:40, Christoph Hellwig wrote:

I'm not happy with the name stx_atomic_write_unit_max_opt - it's vague 
and subjective.

So I am thinking one of these:
a. stx_atomic_write_unit_max_dev
b. stx_atomic_write_unit_max_bdev
c. stx_atomic_write_unit_max_align
d. stx_atomic_write_unit_max_hw

The terms dev (or device) and bdev are already used in the meaning of 
some members in struct statx, so not too bad. However, when we support 
large atomic writes for XFS rtvol, the bdev atomic write limit and 
rtextsize would influence this value (so just bdev might be a bit 
misleading in the name).

As for stx_atomic_write_unit_max_align, it would mean "max 
alignment/granularity" for possible HW offload. Not great.

stx_atomic_write_unit_max_hw would match the bdev request queue sysfs 
names, but that it a different concept to statx. And it has the same 
issue as bdev for rtvol, above.

Any further suggestions or comments?

> On Fri, Mar 21, 2025 at 10:20:21AM +0000, John Garry wrote:
>> Coming back to what was discussed about not adding a new flag to fetch this
>> limit:
>>
>>> Does that actually work?  Can userspace assume all unknown statx
>>> fields are padded to zero?
>>
>> In cp_statx, we do pre-zero the statx structure. As such, the rule "if
>> zero, just use hard limit unit max" seems to hold.
> 
> Ok, canwe document this somewhere?
> 

Sure, but I want to decide on the name first.. if using 
stx_atomic_write_unit_max_bdev/_dev/hw, then it would be odd that this 
value reports 0 for old kernels (as the bdev limit would never really be 0).

Then if we have rule "stx_atomic_write_unit_max_bdev=0 means that 
stx_atomic_write_unit_max_bdev = stx_atomic_write_unit_max", this breaks 
for when we solely rely on FS-based atomics, as 
stx_atomic_write_unit_max_bdev would be 0 there and that should really 
mean 0 (and not stx_atomic_write_unit_max).

So then we should have a new mask to fetch this field, which is not 
ideal, but ok.


