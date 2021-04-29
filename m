Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B536836E25C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhD2AIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 20:08:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57445 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD2AIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:08:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210429000742epoutp0399736818dbd9c6f19ee632a38a2a9090~6K4QfTDtQ2447724477epoutp032
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 00:07:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210429000742epoutp0399736818dbd9c6f19ee632a38a2a9090~6K4QfTDtQ2447724477epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619654862;
        bh=BE/TME4CiVTJ9+/nAG2rbZFGe6UK/I6jrCxlF+ekePs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KMJF6dN4zN0VXfreDa+VuynVAf/7sUFfhFbxdZ9PSdkGiDE6nvyLxjhbGxDReidwr
         rP0hllHnQGhWkyuWrS8wrtUnqr3p1x4MsxugAv6KZ3dbEnzuyCftbhbzymoE1w1EKx
         IuqWbyhtfW8tVwurvxcnoSixbayAppmq8JcRW6/o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210429000741epcas1p43570f019561fe71fea71c9dee09df2e8~6K4QCjalA0040000400epcas1p44;
        Thu, 29 Apr 2021 00:07:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FVwms0FQDz4x9QK; Thu, 29 Apr
        2021 00:07:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.55.09578.CC8F9806; Thu, 29 Apr 2021 09:07:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210429000740epcas1p2f0638dd4cbf636663fd7ef7108c22c57~6K4OaPKvv0998309983epcas1p2P;
        Thu, 29 Apr 2021 00:07:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210429000740epsmtrp23b49ec0a1d7e8c7125d6fbff9180defb~6K4OZMPBa0820508205epsmtrp2n;
        Thu, 29 Apr 2021 00:07:40 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-76-6089f8cc8e28
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.A7.08163.BC8F9806; Thu, 29 Apr 2021 09:07:40 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210429000739epsmtip203142cd272020caec2157d10ca1980bb~6K4OHnDqB1239812398epsmtip2b;
        Thu, 29 Apr 2021 00:07:39 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <smfrench@gmail.com>, <senozhatsky@chromium.org>,
        <hyc.lee@gmail.com>, <viro@zeniv.linux.org.uk>, <hch@lst.de>,
        <hch@infradead.org>, <ronniesahlberg@gmail.com>,
        <aurelien.aptel@gmail.com>, <aaptel@suse.com>,
        <sandeen@sandeen.net>, <dan.carpenter@oracle.com>,
        <colin.king@canonical.com>, <rdunlap@infradead.org>,
        <willy@infradead.org>
In-Reply-To: <20210428191325.GA7400@fieldses.org>
Subject: RE: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Date:   Thu, 29 Apr 2021 09:07:39 +0900
Message-ID: <005c01d73c8b$ab309ed0$0191dc70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEyw8UcQFiOkygfL6nbawEwj6LAkgNL6ZwbA1HSEiar3p7MkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+69vb0g1UsBPWGJ1Ca+WHjUUrgYWAygu4H9Ab6mbgm9ode2
        s7RdHzo1ww4jrw2kugcWRAdi5hzP4bAgOmFA0CY+BmaO9wIGhbpCEdwQtpbLMv77nN/5/s73
        fM+DQIV/4MGEWmtiDVpGI8Z9sZ/at0aEOV7nyyMHSrZTnznvY1TXxAKfGv/yEDV/vRCnJha/
        waj7xRUIde16B0I9GfqTT91q7caoX5vLcMrZ75ktLJrmUWd6QqmW+gqcmhxvx6kHC108av51
        Gb7Dn7ZZCnG61PIIo+u+ysZpu22AT//4XSjd8tSC01Njv2N0Y+UIQtc29mK0u2E93TDqRFJX
        HdLEqVhGwRpErDZDp1BrlfHilD3piemy6EhJmCSWihGLtEwmGy9Oei81bJda48kkFh1lNGZP
        KZUxGsUR78QZdGYTK1LpjKZ4MatXaPSSSH24kck0mrXK8Axd5nZJZOQ2mUcp16jqf5lC9D/7
        feIeU1lACVEAfAhIRsHiHBe/APgSQvImgE8qXyHcYBrAe8UvcG7gBrDwYhMoAMRSS4k7i6s3
        A/h40A28SwnJcQAnW7O8jJNhcPHNHdzLgWQ47DvrXLJAyTIU9vflLjX4kBL4w6QL8XIAuRPe
        rVlEvYyRG2Hn7ekljYCMhdWdLpRjf9h9YRTzMkqGwCZnGcplEMG/xq7yOLMEaH9TzuM0gbA0
        P2dZ87kPbKoWcpwEKzvr+RwHwBddjcscDN0vW3Eu5Ek4dWe5NQ/A8bl4jqXwaW0dzytBya2w
        tjmCK2+A9vmLgHNdDV+++oLHrSKAeTnLphth0eN2hOO3YEGui18MxLYVuWwrctlW7N/2v9ll
        gH0P1rJ6Y6aSNUr0kpU33QCWHnuo7CawOl3hbQAhQBuABCoOFMzX5MuFAgVz/ARr0KUbzBrW
        2AZknpO2osFBGTrPb9Ga0iWybVKplIqKjomWScXrBMrEk3IhqWRM7BGW1bOG//oQwifYgjiY
        7LyjZ6VDXze38CtM8xUHd6ZsVkgv3Nhz+9vh8nvniFNvryYS/D8u5RFz06qIECs/YO2jvqC5
        ykRnql9a+ZmxmiLq4Udp9uSq5H2xO1q6BZsfOg7Ht/Xlnp6dXj/T2vuMqbulfncg+bTfqX6H
        MNMfO75rSPBbt2/qP5ap/hp71d6DamzTmjTD5XrYeUwdHtC/6YZC5nAoOi4dG3m+KiRmv9V+
        pSHFGXRi97C1JeOA1XRtQ2Pemg97k9NHlJ/ORB8J2TvUc8Usz76U+/7z2av7Bh/E/d2XJT+w
        Dmc/GNAJFhJNozNR1f5+d5PM56J2Vz47XHzeNTvcsyUjpVw0MdhQ1ZEgxowqRhKKGozMv9xr
        8al1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvO6ZH50JBqc7mC0a355msTj++i+7
        xYspURa/V/eyWbz+N53F4vSERUwWK1cfZbK4dv89u8WevSdZLC7vmsNm8fYOULa37xOrResV
        LYvdGxexWbx5cZjN4vzf46wWv3/MYXMQ9JjV0MvmMbvhIovHhqlNbB47Z91l99i8Qstj980G
        No+PT2+xeGxZ/JDJY/2WqywenzfJeWx68pYpgDuKyyYlNSezLLVI3y6BK2PjkY9MBQd4Kj4/
        zWhgnMHRxcjBISFgIjHjc10XIxeHkMAORokjsxvZuxg5geLSEsdOnGGGqBGWOHy4GKLmGaPE
        4m+TmEBq2AR0Jf792c8GYosI6Enc7n/LDlLELLCBWWJH8102iI7NjBIbL51hBKniFDCUWPPm
        A1i3sICrxMF1/5hBbBYBVYlj+z6B1fAKWEqsPfaBGcIWlDg58wkLyBXMQBvaNoKVMAvIS2x/
        O4cZ4lAFiZ9Pl7FCHOEksfPPPFaIGhGJ2Z1tzBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4
        Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOMa1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe3+s6E4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg2tJ372jgMo25
        6tkbLO6XJkXL6xV+6BA/k/DimXeT2vYC+ahNHyRf1te/fSAdqzZXu3WqvLDoVrvwp1VpV4rF
        Vm7ulNvTtClyVdDlmJ2ajwsvS3492hznWunC+eqMS0h8ROXV1TZL3S682usiOv/kifdLDacs
        figez673o2Tdv/e/tpd7qfEUVC1R+rqKv1dhO2vzr7+lJ250R2/WfyNsJfo9aZ5ngOyR0lvh
        vq5aiZkdP66dC+rb8L547pxnfLs7LnZ3uD8NUxdYaz7rwPmfXzpn5u5S+h35iDdDrm+x4K8p
        /pmbGqZeVX/XHPdR+f0DlrvHFRWu1Oj0/Pr8plaLvVRxcqCF9CPuIAe3tZsClFiKMxINtZiL
        ihMBMwEakWADAAA=
X-CMS-MailID: 20210429000740epcas1p2f0638dd4cbf636663fd7ef7108c22c57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
        <20210422002824.12677-1-namjae.jeon@samsung.com>
        <20210428191325.GA7400@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
> > ACLs                           Partially Supported. only DACLs available, SACLs
> >                                (auditing) is planned for the future. For
> >                                ownership (SIDs) ksmbd generates random subauth
> >                                values(then store it to disk) and use uid/gid
> >                                get from inode as RID for local domain SID.
> >                                The current acl implementation is limited to
> >                                standalone server, not a domain member.
> >                                Integration with Samba tools is being worked on to
> >                                allow future support for running as a domain member.
> 
Hi Bruce,
> How exactly is this implementing ACLs?  I grepped through the code a bit and couldn't quite figure it
> out--it looked like maybe it's both converting to a POSIX ACL and storing the full SBM ACL in an xattr,
> is that correct?  When you read an ACL, and both are present, which do you use?
If 'vfs objects = acl_xattr' parameter is defined in smb.conf, ksmbd store both.
If not, only posix acl will be stored. To avoid translation from posix acl to ntacl from request of client,
ksmbd use ntacl in xattr first.
> 
> Also it looked like there's some code from fs/nfsd/nfs4acl.c, could we share that somehow instead of
> copying?
Hm.. I do not know how to share the code with nfsd at present. Maybe we can discuss it again after upstream ?
Any thought ?
> 
> --b.

