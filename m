Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770DC36BA4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhDZTuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:50:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241238AbhDZTuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:50:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QJaONP139849;
        Mon, 26 Apr 2021 15:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nLW8yqCLPoKnkpov57uBXMJZwao/yMKymkGF07mYGII=;
 b=XzsEN6TOlQQYwErcJY3JyglCULqJk7TjlK1Mj0xFmJrDKGQX8P3qK/jJ22Cx4RpO1iCI
 2USoSDC3Aa3oRtpwBS6EF24ISsPktWdT7AwUdRRZUpbZnMo2oCfgEkJ2KiMNvZ91mSoH
 YrGzh1bi5KoyZMoHGP5ljdiuTNvoeFLX63nAR1+CWhWtI/TdhxG1y3xEwJEdSnWVmFF0
 J5eojAwmkn0OEjnDPjUiNwdaBnMpFYE4yRs3lRipL6o4s0nj0EB/7f1AJC/UnfMeLVmv
 5FwG5i/dNjoWWr7Te4PFF4Abme/nsR1FjNfTkpgIK9JtXQoAy5luaIEcScfhCbJmSZN0 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38625xk58w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 15:49:49 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QJcVv6001453;
        Mon, 26 Apr 2021 15:49:48 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38625xk585-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 15:49:48 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJf5KR000332;
        Mon, 26 Apr 2021 19:49:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 384ay8ghmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 19:49:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QJnI0s24576286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 19:49:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7836AE053;
        Mon, 26 Apr 2021 19:49:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAFD3AE045;
        Mon, 26 Apr 2021 19:49:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.108.190])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 19:49:40 +0000 (GMT)
Message-ID: <a69b29c5be3d523dae0febe672693601b794bee6.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/12] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 15:49:39 -0400
In-Reply-To: <d4aba724-2935-467b-e57c-cd961112190b@schaufler-ca.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-5-roberto.sassu@huawei.com>
         <d4aba724-2935-467b-e57c-cd961112190b@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y3RRMTC_MA1EoB3w6hQjt0t-ESX4JkOw
X-Proofpoint-GUID: U6NDY0Wwrbt2jrs_iS9_P6UP6wGEr7Xv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 09:17 -0700, Casey Schaufler wrote:
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 565e33ff19d0..1f029e4c8d7f 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -577,21 +577,40 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> >       if (result == 1) {
> >               if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
> >                       return -EINVAL;
> > -             ima_reset_appraise_flags(d_backing_inode(dentry),
> > -                     xvalue->type == EVM_IMA_XATTR_DIGSIG);
> >               result = 0;
> >       }
> >       return result;
> >  }
> >  
> > +void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> > +                          const void *xattr_value, size_t xattr_value_len)
> > +{
> > +     const struct evm_ima_xattr_data *xvalue = xattr_value;
> > +     int result;
> > +
> > +     result = ima_protect_xattr(dentry, xattr_name, xattr_value,
> > +                                xattr_value_len);
> > +     if (result == 1)
> > +             ima_reset_appraise_flags(d_backing_inode(dentry),
> > +                     xvalue->type == EVM_IMA_XATTR_DIGSIG);
> > +}
> > +
> 
> Now you're calling ima_protect_xattr() twice for each setxattr.
> Is that safe? Is it performant? Does it matter?

The first time the call to ima_protect_xattr() prevents the
security.ima from being inappropriately modified.  The second time it
resets the cached status flags.  From a performance perspective,
unnecessarily re-calcuating the file hash is worse than rechecking the
security xattr string.
 
Mimi

