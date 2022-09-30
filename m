Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18DE5F0327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 05:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiI3DTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiI3DTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:19:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75977CE00;
        Thu, 29 Sep 2022 20:19:39 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U2tmEj016068;
        Fri, 30 Sep 2022 03:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=COxME/9IbYjT8EaHgeS5lglvsO5fn1PChFiS6kGzosM=;
 b=RT3oTwZOE19/7FaehsUdIDp79te/yfqfDMuHZ/yT9oFemk80AdgBmloNIExaoz+EkSGG
 +5nttbZat3vWis7Xg0turSbS1PVCU2yWTi4b9Vi8jDyZ9XsyPz6eSjTrwFaZJDIZlEMh
 R4ze8oagFkrOqUNN6Xgu/IFC1Lvn1XWzO0GNsJLKfAkpEYIibAICFUN1qCbF3GeuBlxg
 zFGwIinDjo4GMK8Vrga0SFexwJYiY/Z8p/omJ5jjn+iillEsGLX1e7Baxc4wm6mNCKwj
 91phOvCiVIj3d3+Slns5iuL/ypRAIwjs5a5wuAZPDjcaQuByrjBFGqSVc83eanoEzcaJ Ww== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwr3vrgsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 03:19:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28U36Xpm026098;
        Fri, 30 Sep 2022 03:19:31 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3jsshbffsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 03:19:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28U3JUeb19137148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 03:19:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4FB58052;
        Fri, 30 Sep 2022 03:19:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAEC758056;
        Fri, 30 Sep 2022 03:19:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.161.243])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 03:19:29 +0000 (GMT)
Message-ID: <53f18ae71d0b8811fbd23c87a80447bc159832e0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/30] integrity: implement get and set acl hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 29 Sep 2022 23:19:29 -0400
In-Reply-To: <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com>
References: <20220929153041.500115-1-brauner@kernel.org>
         <20220929153041.500115-13-brauner@kernel.org>
         <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mhqGID2SYy7fqE3BveNPbAQr3ot-v4BC
X-Proofpoint-ORIG-GUID: mhqGID2SYy7fqE3BveNPbAQr3ot-v4BC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_01,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=868 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Paul,

On Thu, 2022-09-29 at 15:14 -0400, Paul Moore wrote:
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index bde74fcecee3..698a8ae2fe3e 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> >         return result;
> >  }
> >
> > +int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +                     const char *acl_name, struct posix_acl *kacl)
> > +{
> > +       if (evm_revalidate_status(acl_name))
> > +               ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> > +
> > +       return 0;
> > +}
> 
> While the ima_inode_set_acl() implementation above looks okay for the
> remove case, I do see that the ima_inode_setxattr() function has a
> call to validate_hash_algo() before calling
> ima_reset_appraise_flags().  IANAIE (I Am Not An Ima Expert), but it
> seems like we would still want that check in the ACL case.

Thanks, Paul.  The "ima: fix blocking of security.ima xattrs of
unsupported algorithms" patch in next-integrity branch, moves the hash
algorithm checking earlier.

-- 
thanks,

Mimib

