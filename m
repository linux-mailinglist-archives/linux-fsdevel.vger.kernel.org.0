Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35C2668F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 08:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjAMHWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 02:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjAMHWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:22:13 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F266ADB2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 23:10:07 -0800 (PST)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230113071004epoutp047827c112f0107df52db5efc574fb1a2f~5zLKsbNGC2954429544epoutp040
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 07:10:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230113071004epoutp047827c112f0107df52db5efc574fb1a2f~5zLKsbNGC2954429544epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673593804;
        bh=nySZtC4nC3yjYwyB+PcjQS/RAIICSp5GNHpTez+qI6U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Oq8e0J2IWOfkr5qPueTJZ8mGkRDZrZxbjUmSDxv8F5O0gBiXeG0Y0dLCwbMotQL5W
         EWP4cRV6rgKkpOXrQibvVRHFkOOiZOJ07lzoGThWlymCr0nA2xm0fm4YACLrk3Mctf
         JRVSrH6+5W8E+hUYJAR6UD4kmACXvwM+5W+VsUfY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20230113071003epcas3p40450d0280d25f0f97245f2fcf6cee867~5zLKP9KhK3228732287epcas3p4F;
        Fri, 13 Jan 2023 07:10:03 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4NtXcC5fqPz4x9QM; Fri, 13 Jan 2023 07:10:03 +0000
        (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230113070623epcas1p3b76c2808a007d4955554773170571e6a~5zH9Bfh2M2701627016epcas1p3H;
        Fri, 13 Jan 2023 07:06:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230113070623epsmtrp173e620c9e7acfd1d09767207f0beef94~5zH9A1PEj2537825378epsmtrp17;
        Fri, 13 Jan 2023 07:06:23 +0000 (GMT)
X-AuditID: b6c32a29-c9bff700000008a3-99-63c102ef9fed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.6D.02211.FE201C36; Fri, 13 Jan 2023 16:06:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230113070623epsmtip2041a3a349311ecb8f2dfd2b55db37c07~5zH81-pdL2601326013epsmtip2I;
        Fri, 13 Jan 2023 07:06:23 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <Yuezhang.Mo@sony.com>, "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        "'Wang Yugui'" <wangyugui@e16-tech.com>,
        =?utf-8?Q?'Bar=C3=B3csi_D=C3=A9nes'?= <admin@tveger.hu>,
        <sj1557.seo@samsung.com>, <cpgs@samsung.com>
In-Reply-To: <PUZPR04MB63167FAB29A81DB38D43DD5A81C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2] exfat: handle unreconized benign secondary entries
Date:   Fri, 13 Jan 2023 16:06:23 +0900
Message-ID: <626742236.41673593803778.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQH0MlAjGgNPUhCi5cBBB3Ep7uj9ygLbAhwkARFdZmYCM4S76gHIUlWNriaH85A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvc908FkgxnnxS2uvHvNZvHykKbF
        xGlLmS327D3JYrHl3xFWiwfzvrBbXH/zkNWB3WP1szlMHptWdbJ59G1ZxejRPmEns8e7BRNY
        PD5vkgtgi+KySUnNySxLLdK3S+DKeN4wm7Xgi3DF9g+nmRsYdwp0MXJySAiYSNw/uZqti5GL
        Q0hgN6NE854FjF2MHEAJKYmD+zQhTGGJw4eLIUqeM0p8PHeACaSXTUBX4smNn8wgtoiAq8Te
        KetZQYqYQebc3bOKBSQhJPCZSWL9OxMQm1MgVqL7zz82kKHCAl4Sn5b7gZgsAqoS516WglTw
        ClhKrD/YwAphC0qcnPkEbAqzgLbE05tPoWx5ie1v5zBDnK8gsfvTUVaIE/wkDr16ww5RIyIx
        u7ONeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        jigtzR2M21d90DvEyMTBeIhRgoNZSYR3z9H9yUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3Sd
        jBcSSE8sSc1OTS1ILYLJMnFwSjUw+XKYOwR1WNXy2xa5vbeofDCtbNGLSbvVO5esyFm20Eou
        jHHxBVP7K5WCmneeLJ1aeMCAY873XQw8+bMYeOX/x2yfe4w1NS55wsO3NlHa6ux7+syfxJ51
        /ncwu6taJ/dtkss9Hf+GYv8fqyf6tLyz9tlW3+4WKfZ1j9X65Aqjtc/epLT7L/eV/vNW+cop
        /penNDtuvv04hbHu6h35lLU9wjsO1x8/tcCPn/NLZ/DyT5XLdnBMaDea4MG8zdvtsOrtxWHp
        Sw83LrThXcZQfy7YeKVQzozLFznl0peulVAp/Wls9UbISvtsRyCX/+xzT8vsbOexFf24eft1
        7//AMrWFPhc3lxvMLjsh1HxpwoufSizFGYmGWsxFxYkAc7jU6RcDAAA=
X-CMS-MailID: 20230113070623epcas1p3b76c2808a007d4955554773170571e6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20230113061305epcas1p2ec0bdad0fbe3cca6e3142f99e9260226
References: <20230112140509.11525-1-linkinjeon@kernel.org>
        <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
        <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
        <CGME20230113061305epcas1p2ec0bdad0fbe3cca6e3142f99e9260226@epcas1p2.samsung.com>
        <PUZPR04MB63167FAB29A81DB38D43DD5A81C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >
> > >> +		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
> > >> +			exfat_free_benign_secondary_clusters(inode, ep);
> > >> +
> > >
> > > Only vendor allocation entry(0xE1) have associated cluster
> > > allocations, vendor extension entry(0xE0) do not have associated
> > > cluster
> > allocations.
> > This is to free associated cluster allocation of the unrecognized
> > benign secondary entries, not only vendor alloc entry. Could you
> > elaborate more if there is any issue ?
> 
> From exFAT spec, there are 2 types benign secondary entries only, Vendor
> Extension entry and Vendor Allocation entry.
> 
> For different Vendor, Different Vendors are distinguished by different
> VendorGuid.
> 
> For a better understanding, please refer to https://dokumen.pub/sd-
> specifications-part-2-file-system-specification-version-300.html. This is
> the specification that the SD Card Association defines Vendor Extension
> entries and Vendor Allocation entries for SD card. "Figure 5-3 :
> Continuous Information Management" is an example of an entry set
> containing a Vendor Extension entry and a Vendor Allocation entry. In the
> example, we can see vendor extension entry(0xE0) do not have associated
> cluster allocations.

From "8.2 in the exFAT spec" as below, it is needed to handle all
unrecognized benign secondary entries that include NOT specified
in Revision 1.00.

8.2 Implications of Unrecognized Directory Entries
Future exFAT specifications of the same major revision number, 1,
and minor revision number higher than 0, may define new benign primary,
critical secondary, and benign secondary directory entries. Only exFAT
specifications of a higher major revision number may define new critical
primary directory entries. Implementations of this specification, exFAT
Revision 1.00 File System Basic Specification, should be able to mount
and access any exFAT volume of major revision number 1 and any minor
revision number. This presents scenarios in which an implementation
may encounter directory entries which it does not recognize.
The following describe implications of these scenarios:
...
  4. Implementations shall not modify unrecognized benign secondary
  directory entries or their associated cluster allocations.
  Implementations should ignore unrecognized benign secondary directory
  entries. When deleting a directory entry set, implementations shall
  free all cluster allocations, if any, associated with unrecognized
  benign secondary directory entries.


