Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C1372C6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEDOvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 10:51:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230388AbhEDOvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 10:51:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144EZQd5193436;
        Tue, 4 May 2021 10:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5TIt36ZcJu4V/FWOJS4qMQXOoQ4JkSCPRpiyX/VDPrg=;
 b=MAKrfSCIODZlN7kPKSQ3wTHj4/hIU403bJY5bNRbcK95ihFyXKS8/RCzo3wmo88GaHbF
 XTuILo6dLGZGE64+zAlgDmqIF2MwPqAC+np3N4lwf1Ecl6hJt/B5bkw194fCXb3W/sk4
 RQ5RTxi4JfOR/Pa/e7zEvQroR31gzpidBRK+2YEkxc8GgWZ0ekmLF/SvySTBrYkYeBID
 X200MG8CO92J1wWpFKWuxDCgd9uyATfcVZf1DOOMJsQVz9/tywsqZcKDnnxNvTNmGP0r
 rp0ZN7WQnnFw+5eYTDx8UGRgoZYpGfnaxqXpixoajGamXs5FbK53EGf+QAhkiWYXwAJu Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b7gmhwmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 10:50:00 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144EafUL002904;
        Tue, 4 May 2021 10:50:00 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b7gmhwkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 10:50:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144EWcc7029383;
        Tue, 4 May 2021 14:49:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 388x8hh8xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 14:49:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144EnuC458393062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 14:49:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F91A405B;
        Tue,  4 May 2021 14:49:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F56A4054;
        Tue,  4 May 2021 14:49:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.38.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 14:49:54 +0000 (GMT)
Message-ID: <10f9ab52c487b9dcde000f8aee77c8e04979a485.camel@linux.ibm.com>
Subject: Re: [PATCH v5 07/12] evm: Allow xattr/attr operations for portable
 signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 04 May 2021 10:49:53 -0400
In-Reply-To: <f26f4b6fd3074bb4a6f0f0ff4911a202@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-8-roberto.sassu@huawei.com>
         <75e8a4f70dfbbfa4cf5b923ab0ac92768e1e2de5.camel@linux.ibm.com>
         <f26f4b6fd3074bb4a6f0f0ff4911a202@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DvcGGYHomvZgiaAjGNMQvTV8mfY5ocYu
X-Proofpoint-ORIG-GUID: Mk-5nBQCpihp5UoTGEdxsRivgCGSLpSc
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_08:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-05-04 at 14:28 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, May 3, 2021 2:13 AM
> > Hi Roberto,
> > 
> > > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > > index 2271939c5c31..2ea0f2f65ab6 100644
> > > --- a/include/linux/integrity.h
> > > +++ b/include/linux/integrity.h
> > >
> > > @@ -238,9 +241,12 @@ static enum integrity_status
> > evm_verify_hmac(struct dentry *dentry,
> > >  		break;
> > >  	}
> > >
> > > -	if (rc)
> > > -		evm_status = (rc == -ENODATA) ?
> > > -				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
> > > +	if (rc) {
> > > +		evm_status = INTEGRITY_NOXATTRS;
> > > +		if (rc != -ENODATA)
> > > +			evm_status = evm_immutable ?
> > > +				     INTEGRITY_FAIL_IMMUTABLE :
> > INTEGRITY_FAIL;
> > 
> > The original code made an exception for the -ENODATA case.   Using a
> > ternary operator made sense in that case.   Inverting the test makes
> > the code less readable.  Please use the standard "if" statement
> > instead.
> 
> Did I understand correctly that the code should be:
> 
>                 evm_status = INTEGRITY_NOXATTRS;
>                 if (rc != -ENODA
>                         evm_status = INTEGRITY_FAIL;
>                         if (evm_immutable)
>                                 evm_status = INTEGRITY_FAIL_IMMUTABLE;
>                 }
> 
 
                if (rc == -ENODATA)
                        evm_status = INTEGRITY_NOXATTRS;
                else if (evm_status == evm_immutable)
                        evm_status = INTEGRITY_FAIL_IMMUTABLE;
                else
                        evm_status = INTEGRITY_FAIL;

I think keeping it simple makes it really clear that ENODATA is an
exception.

thanks,

Mimi

