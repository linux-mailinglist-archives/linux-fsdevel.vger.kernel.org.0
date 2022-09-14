Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C05B863A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINKXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiINKWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:22:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5D7A749
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:22:48 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220914102244epoutp03330988f28723cf500b4f36d0fd2807ed~Usv2akFBh2684426844epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 10:22:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220914102244epoutp03330988f28723cf500b4f36d0fd2807ed~Usv2akFBh2684426844epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663150964;
        bh=3XsgNhx/oEAbk//ISB15e+OTI46PpfVBX4MSK1qwYYk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Rw7Ydyo3tRUc2xkK9r7L8ICTn9Hww2qsJ8/nI5fqoVZD4MGU2fdwdAjXAxo5hIqgZ
         aJPj0uwMqFUJs6Ikwt15DccJcp7EJOtrfz2DbE2epY9xE+G4y8XTaKwzAReWMXfQSZ
         wsVCGQw6DHFfK3JwXlc8MEIvGdWiJkHA2JVz/4c8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220914102244epcas1p46ddb7d06cb5077aa7d37f5053bf5b88a~Usv2LKy0s2766327663epcas1p4O;
        Wed, 14 Sep 2022 10:22:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.242]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MSGcN0QYPz4x9Pr; Wed, 14 Sep
        2022 10:22:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.00.18616.37BA1236; Wed, 14 Sep 2022 19:22:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220914102243epcas1p12cd7638935cddc8a2c81069b41724d0c~Usv1hxWEz3113331133epcas1p1a;
        Wed, 14 Sep 2022 10:22:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220914102243epsmtrp2a154ce60d0c83b139c76cc1b476c836b~Usv1hDkUo0251902519epsmtrp2V;
        Wed, 14 Sep 2022 10:22:43 +0000 (GMT)
X-AuditID: b6c32a38-6cfff700000048b8-a8-6321ab73c501
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.51.14392.37BA1236; Wed, 14 Sep 2022 19:22:43 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220914102243epsmtip10b696ac82c72f40ea09f04d7da05eb96~Usv1Udrsg1683016830epsmtip1F;
        Wed, 14 Sep 2022 10:22:43 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Rover'" <739817562@qq.com>,
        "'linkinjeon'" <linkinjeon@kernel.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <tencent_52978C540CBFA2747B715C811F0D99530E07@qq.com>
Subject: RE: RE: [PATCH v1] exfat: remove the code that sets FileAttributes
 when renaming
Date:   Wed, 14 Sep 2022 19:22:43 +0900
Message-ID: <08bb01d8c823$ed1e0dd0$c75a2970$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLiLS1ckQU2fx+m2qoL2gnRLP1zpQJkLg6Wq7jCpzA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmvm7xasVkg+V7bCxaXu5gtZg4bSmz
        xZ69J1ksLu+aw2ax5d8RVgdWj02rOtk8bj1by+rRt2UVo8fnTXIBLFENjDaJRckZmWWpCql5
        yfkpmXnptkqhIW66FkoKGfnFJbZK0YaGRnqGBuZ6RkZGesaWsVZGpkoKeYm5qbZKFbpQvUoK
        RckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIMfqFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmDH/
        2Uz2gsNKFY8u7mZpYHwq08XIySEhYCJx5tVDxi5GLg4hgR2MErdWrYJyPjFK/Fndww7hfGOU
        OHPwAzNMy8sd+9kgEnsZJZ5P3wfV8pJR4sjJfhaQKjYBXYknN36CdYgIeEi8f9vCAlLELNDE
        KHH19wmmLkYODk4BJ4kPa51BaoQFoiVWfZvDBmKzCKhKzPz2A8zmFbCUWDjnG5QtKHFy5hOw
        +cwC8hLb386BukhBYveno6wQu6wk7mxYxg5RIyIxu7ONGWSvhEArh8Sq3W/ZIBpcJB7O28IE
        YQtLvDq+hR3ClpL4/G4vVE03MADO8UI0T2CUaLlzlhUiYSzx6fNnRpAHmAU0Jdbv0ocIK0rs
        /D2XEcIWlDh9rZsZ4gg+iXdfe1hByiUEeCU62oQgSlQkvn/YyTKBUXkWktdmIXltFpIXZiEs
        W8DIsopRLLWgODc9tdiwwAQ5xjcxgtOqlsUOxrlvP+gdYmTiYDzEKMHBrCTC2xeikCzEm5JY
        WZValB9fVJqTWnyIMRkY2BOZpUST84GJPa8k3tDE2MDACJgQzS3NjYkQtjQwMTMysTC2NDZT
        EufV02ZMFhJITyxJzU5NLUgtgtnCxMEp1cA0aeURy0vdTPoxDgyfV/wOX+L+0F5lAq9Ng8tq
        1RvzbYKzpX5dOrLmjvoCYf+9MxROtWjPe2cw1aRbaYtz6LeFho0btvZdeJWiEZ20Oq9Uv1bo
        IheDafFW3f1xC7p5mddUFOzqfmCnumha2oZ12yK52y0Oam37selN9qPyBXWpCybpaXdFL7ii
        pye1ob4rp3VB0s+621y66zY/uS3wrjqiQXLJev7XnMI/+P7qSF/R2LT4+70VausjL5+anMh4
        vED+tZpdwKH0YCXXEEVPwWuc1rESQttfLPCr2STqf2zuuRXOLrb8E5r+dh08r24t/t6gJd3A
        Kq9p6XUDJTuxl/JNb32OejvP6Oq/dbxHwlCJpTgj0VCLuag4EQBWbUrtYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnG7xasVkg6W9qhYtL3ewWkyctpTZ
        Ys/ekywWl3fNYbPY8u8IqwOrx6ZVnWwet56tZfXo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jPnPZrIXHFaqeHRxN0sD41OZLkZODgkBE4mXO/azdTFycQgJ7GaU2DNlMmMXIwdQQkri4D5N
        CFNY4vDhYoiS54wSfe8aWUB62QR0JZ7c+MkMUiMi4CWx4n8JSA2zQAujxKzGZ1AzJzNKnLhw
        mAWkiFPASeLDWmeQXmGBSImGhudMIDaLgKrEzG8/2EBsXgFLiYVzvkHZghInZz4Ba2UW0JNo
        28gIEmYWkJfY/nYOM8T5ChK7Px1lBbFFBKwk7mxYxg5RIyIxu7ONeQKj8Cwkk2YhTJqFZNIs
        JB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4qW5g7G7as+6B1iZOJgPMQo
        wcGsJMLbF6KQLMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwen
        VAPTvDvhnXe+bJZ4IHR38qmdTX7Olm6F1hXxN1Zkb1Yzb5afkBl1ukipb+G2mJ0L/ZPPbS+c
        tvPwk1sJ7apa2tbPp4vV32TeeDovM1Jhj/9cY5MFbGufyho88y35f6nQI9lGjeFx/C391B+l
        VzbIOovJT5onViH758zKHW8uH1j/ddYbJpvMmhuqRo8XF/NZPJvS//hFtkMpz2KG6xKtqwzf
        tHndqYpacMhzRdCylckd/3eevff+4hOt1RcKtQLqwmTXNyx1MNO7Xu1z2CZ6SVMU3z+W9asO
        l33IyG1dt/ZExQ53wRfTPkf61v5ynfD/a7Dx4aKaUrUzPVFFThZaDm9c3zAUMe0umvJsQ9Fu
        B44JSizFGYmGWsxFxYkAi1EXXgMDAAA=
X-CMS-MailID: 20220914102243epcas1p12cd7638935cddc8a2c81069b41724d0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220914092543epcas1p1526e62ff4587f70d09bcefab3a97cbe2
References: <CGME20220914092543epcas1p1526e62ff4587f70d09bcefab3a97cbe2@epcas1p1.samsung.com>
        <tencent_52978C540CBFA2747B715C811F0D99530E07@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Sungjong,
> 
> This patch is to remove the duplicate setting ATTR_ARCHIVE when renaming.
> 
> We know that a file will not become a directory after being renamed, and a
> directory will not become a file after being renamed.

Sure, rename-op does not change any types of files.

> &gt;&gt;
> &gt;&gt; 		*epnew = *epold;
> So ATTR_ARCHIVE is already set here if rename file.

Do you think ATTR_ARCHIVE represents the file type? If so, you probably
are misunderstanding ATTR_ARCHIVE. It's just like a flag indicating that
there was a change. For example, in case of rename, it's just like a flag
indicating that its name has been changed.

The current linux exfat implementation does not yet provide an IOCTL
to control this attribute, but keep in mind that the ATTR_ARCHIVE may
be removed even if it is a file via another exfat driver.

B.R.
Sungjong Seo

> 
> &gt;&gt; -		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
> &gt;&gt; -			epnew-&gt;dentry.file.attr |=
> cpu_to_le16(ATTR_ARCHIVE);
> No need to set again here.
> 
> &gt;&gt; -			ei-&gt;attr |= ATTR_ARCHIVE;
> ei-&gt;attr doesn't change and already set ATTR_ARCHIVE in
> exfat_fill_inode()
> 
> &gt;&gt; -		}
> 
> Best regards,
> Rover
> 
> ------------------ Original ------------------
> From: "Sungjong Seo" <sj1557.seo@samsung.com>;
> Date: Wed, Sep 14, 2022 04:48 PM
> To: "Rover"&lt;739817562@qq.com&gt;;"'linkinjeon'"<linkinjeon@kernel.org>;
> Cc: "'linux-kernel'"<linux-kernel@vger.kernel.org>;"'linux-
> fsdevel'"<linux-
> fsdevel@vger.kernel.org>;"sj1557.seo"<sj1557.seo@samsung.com>;
> Subject: RE: [PATCH v1] exfat: remove the code that sets FileAttributes
> when renaming
> 
> 
> Hi, Rover,
> 
> This patch seems to violate the exFAT specification below.
> Please refer to the description for ATTR_ARCHIVE in FAT32 Spec.
> 
> * Archive
> This field is mandatory and conforms to the MS-DOS definition.
> 
> * ATTR_ARCHIVE
> This attribute supports backup utilities. This bit is set by the FAT file
> system driver when a file is created, renamed, or written to. Backup
> utilities may use this attribute to indicate which files on the volume
> have been modified since the last time that a backup was performed.
> 
> Thanks.
> B.R.
> 
> Sungjong Seo
> 
> &gt; When renaming, FileAttributes remain unchanged, do not need to be
&gt;
> set, so the code that sets FileAttributes is unneeded, remove it.
> &gt;
> &gt; Signed-off-by: rover &amp;lt;739817562@qq.com&amp;gt; &gt; ---
> &gt;&nbsp; fs/exfat/namei.c | 12 ------------ &gt;&nbsp; 1 file changed,
> 12 deletions(-) &gt; &gt; diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> &gt; index b617bebc3d0f..5ffaf553155e 100644 &gt; --- a/fs/exfat/namei.c
> &gt; +++ b/fs/exfat/namei.c &gt; @@ -1031,10 +1031,6 @@ static int
> exfat_rename_file(struct inode *inode, &gt; struct exfat_chain *p_dir,
> &gt;&nbsp;return -EIO; &gt; &gt;&nbsp; *epnew = *epold; &gt; -if
> (exfat_get_entry_type(epnew) == TYPE_FILE) { &gt; - epnew-
> &amp;gt;dentry.file.attr |= &gt; cpu_to_le16(ATTR_ARCHIVE); &gt; - ei-
> &amp;gt;attr |= ATTR_ARCHIVE; &gt; -} &gt;&nbsp; exfat_update_bh(new_bh,
> sync); &gt;&nbsp; brelse(old_bh); &gt;&nbsp; brelse(new_bh); &gt; @@ -
> 1063,10 +1059,6 @@ static int exfat_rename_file(struct inode *inode, &gt;
> struct exfat_chain *p_dir, &gt;&nbsp; ei-&amp;gt;dir = *p_dir; &gt;&nbsp;
> ei-&amp;gt;entry = newentry; &gt;&nbsp;} else { &gt; -if
> (exfat_get_entry_type(epold) == TYPE_FILE) { &gt; - epold-
> &amp;gt;dentry.file.attr |= &gt; cpu_to_le16(ATTR_ARCHIVE); &gt; - ei-
> &amp;gt;attr |= ATTR_ARCHIVE; &gt; -} &gt;&nbsp; exfat_update_bh(old_bh,
> sync); &gt;&nbsp; brelse(old_bh); &gt;&nbsp; ret =
> exfat_init_ext_entry(inode, p_dir, oldentry, &gt; @@ -1112,10 +1104,6 @@
> static int exfat_move_file(struct inode *inode, &gt; struct exfat_chain
> *p_olddir, &gt;&nbsp; return -EIO; &gt; &gt;&nbsp;*epnew = *epmov; &gt; -
> if (exfat_get_entry_type(epnew) == TYPE_FILE) { &gt; -epnew-
> &amp;gt;dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE); &gt; -ei-
> &amp;gt;attr |= ATTR_ARCHIVE; &gt; - } &gt;&nbsp;exfat_update_bh(new_bh,
> IS_DIRSYNC(inode)); &gt;&nbsp;brelse(mov_bh); &gt;&nbsp;brelse(new_bh);
> &gt; -- &gt; 2.25.1</sj1557.seo@samsung.com></linux-
> fsdevel@vger.kernel.org></linux-
> kernel@vger.kernel.org></linkinjeon@kernel.org></sj1557.seo@samsung.com>

