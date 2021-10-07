Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFF425B03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbhJGSkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:40:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhJGSkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:40:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197HX1R0003394;
        Thu, 7 Oct 2021 14:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ro9WtJnbWiv79sEcwQ/y9b5di6jNFvxnUqDeKfyVHDA=;
 b=MOnw0Yt6oktVmKt65Phxc0OsQe0NDxyj5kn3l90m0LA5Ic6frzK9U3WIrtKRiRjNmglj
 uUJTqKJxwbIvX3DlNHzZX+Flpix3dNrYYDAeuKGo8GsYHY3lMyylbnMfAQYquk7JpR7j
 HNZlnpwkZk/An0lJLCes41GAObcmEk/NZlRYjPQ4YPX9gIJHEz8A1508X1CelHyQGjLG
 P74z/WDX4a7FmsEfB4XYqzBvebrbZ13Z6GJG8Hn56SWygio/3XeMFL5eLQbKNl1njkJh
 F7co/ywFQQTAxiAU1aY2BKCucTUYmdM0jVnBJwggftfJxrXZ2U6lf8VxrFKTFmV2JJf0 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhkcxjb99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 14:37:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 197IQcP3029725;
        Thu, 7 Oct 2021 14:37:32 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhkcxjb8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 14:37:32 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 197IRERb003304;
        Thu, 7 Oct 2021 18:37:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3beepk7kpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 18:37:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 197IbQU746989638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 18:37:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98963A4053;
        Thu,  7 Oct 2021 18:37:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B28DCA404D;
        Thu,  7 Oct 2021 18:37:18 +0000 (GMT)
Received: from sig-9-65-203-7.ibm.com (unknown [9.65.203.7])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Oct 2021 18:37:18 +0000 (GMT)
Message-ID: <7ee6ba1200b854fc6012b0cec49849f7c0789f42.camel@linux.ibm.com>
Subject: Re: [PATCH v12 0/3] Add trusted_for(2) (was O_MAYEXEC)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>
Cc:     bauen1 <j2468h@googlemail.com>, akpm@linux-foundation.org,
        arnd@arndb.de, casey@schaufler-ca.com,
        christian.brauner@ubuntu.com, christian@python.org, corbet@lwn.net,
        cyphar@cyphar.com, deven.desai@linux.microsoft.com,
        dvyukov@google.com, ebiggers@kernel.org, ericchiang@google.com,
        fweimer@redhat.com, geert@linux-m68k.org, jack@suse.cz,
        jannh@google.com, jmorris@namei.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        madvenka@linux.microsoft.com, mjg59@google.com,
        mszeredi@redhat.com, mtk.manpages@gmail.com,
        nramas@linux.microsoft.com, philippe.trebuchet@ssi.gouv.fr,
        scottsh@microsoft.com, sean.j.christopherson@intel.com,
        sgrubb@redhat.com, shuah@kernel.org, steve.dower@python.org,
        thibaut.sautereau@clip-os.org, vincent.strubel@ssi.gouv.fr,
        viro@zeniv.linux.org.uk, willy@infradead.org
Date:   Thu, 07 Oct 2021 14:37:17 -0400
In-Reply-To: <4c4bbd74-0599-fed5-0340-eff197bafeb1@digikod.net>
References: <20201203173118.379271-1-mic@digikod.net>
         <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
         <2a4cf50c-7e79-75d1-7907-8218e669f7fa@digikod.net>
         <202110061500.B8F821C@keescook>
         <4c4bbd74-0599-fed5-0340-eff197bafeb1@digikod.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jOAagv9-Zy3caZx8ORtgWB-IBZAybLlH
X-Proofpoint-ORIG-GUID: qojyI-7uaVr1-wTGd2steGJ3omVhfkri
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=373 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070119
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-10-07 at 20:29 +0200, Mickaël Salaün wrote:
> On 07/10/2021 00:03, Kees Cook wrote:
> > On Fri, Apr 09, 2021 at 07:15:42PM +0200, Mickaël Salaün wrote:
> >> There was no new reviews, probably because the FS maintainers were busy,
> >> and I was focused on Landlock (which is now in -next), but I plan to
> >> send a new patch series for trusted_for(2) soon.
> > 
> > Hi!
> > 
> > Did this ever happen? It looks like it's in good shape, and I think it's
> > a nice building block for userspace to have. Are you able to rebase and
> > re-send this?
> 
> I just sent it:
> https://lore.kernel.org/all/20211007182321.872075-1-mic@digikod.net/
> 
> Some Signed-off-by would be appreciated. :)
> 

From the cover letter, 

It is important to note that this can only enable to extend access
control managed by the kernel.  Hence it enables current access control
mechanism to be extended and become a superset of what they can
currently control.  Indeed, the security policy could also be delegated
to an LSM, either a MAC system or an integrity system.  For instance,
this is required to close a major IMA measurement/appraisal interpreter
integrity gap by bringing the ability to check the use of scripts [1].
Other uses are expected, such as for magic-links [2], SGX integration
[3], bpffs [4].

From a quick review of the code, I don't see a new security hook being
defined to cover these use cases.

thanks,

Mimi

> > 
> > I've tended to aim these things at akpm if Al gets busy. (And since
> > you've had past review from Al, that should be hopefully sufficient.)
> > 
> > Thanks for chasing this!
> > 
> > -Kees
> > 


