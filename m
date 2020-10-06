Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4CF284953
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFJZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 05:25:55 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:33074
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJFJZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601976354; bh=qFbuKRmrzUWd5SE3tGcypHHoWywgg3aF/p/xNRx13LQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SJTIOHCHuKDepxV7veB31DhKrxChLKHAwKLB18lewWHHs+RbjkbtOjx/jbu2RMTgcYC5uJ2omMnAsrvagtq1LVhN4qBfmV4SAQR60c0f8Ry7ugK9sarayb4bKCBWeiPEKDK4bI/2i7/GzEK/Y64Y8VlWWWheJLK1V0AojsLNoWFfFr3KXnFkpQaP2y/SbZ4NTR8M2YTyWVXGRTFnI0WZYs41nD0en4KHRnZWzQ8zQMMk+BMPvaiQ1v14Hh0q1OAdfJfl0SPCo+z2ZM286j9BNoOrKtLuR6E3yKoPIc31TA+lAoO6BdJToktJhaI2ALHB2Z7Z37LFbVfNIjrqgkGwhw==
X-YMail-OSG: BKH6F5IVM1mGNxVlYgqu0K0ARKKA4Tmq5zy7gveFgBSURysnV3ohL303dShPX70
 VgFKF0ef_Sy23j_IHH9w4GSvPduaTtzhFb0mxSVcjM.7z9I7Gzu0Ed7Y1ddGbxFVjacxEIulO0oR
 Bi2qOkMo26YEGVByBJUJaFj5_aSHTvSR0LKR6K7joarJMZ7akI2PjjISprdw9yp0pNd4.GcIUIEL
 yuKgZfzPle54CPuaWLbkJYT2TbGIPMuRpHj_QkogjF.8bOplYm8KCXi8Ygi0DEaxaqC2nrBEwqYJ
 CNaVafAuYtQCFC9A4Yd9DfHIHJVDCYZL.4nbFpZZL0XZZbBzhMGELj6tSeu28AeyI1.LV58sw2tb
 cD9xRqeTsIc67Rbu_bTc2zvYzvbp9y.cMzRxb_bcalhCLNikRywyxi2FLPxu94hIiw9ATnDjTgcu
 5EoKLI_s8VTof90CUMPjnomaEKGJ60XULvJwdCX8FApFvaWML1lQiw_Cxree5aSpHhiJ2yw66ERC
 YV_n1HQEXjnuO0Iqx_iKbLn8nG1Qsg2ZrbSw4dTUtGpPDCv6XWvXtR_tlDahYT8E1wM.WOGMCvbd
 qF5DybMQzzTlHCHbeXihiSG1Fr_jI8kv5yYkQQPCHU0Mu8OavIB0oFCnzOoT2tLtj7q2cwiz5Vgz
 .rVsGdRRmWnNGoMC3n2OU.m_03YdmxWCfTvPyOvByb7lBK.vUmKEPrmwJzEOkcpulyvbg.29.M.B
 z_kW1xV6wxUwCt03Y9pTfCEbluQSaZJxZa.TC0WLhpxAijpayahes9lmJlXuxauBKgBJlcOsHRQ0
 C8In0B58Q4hllZDRsNRh7TLHjIZnLohpwm1z1fSd_legawiP9x3FGO0jEzGnHidESYpNp2qO43F5
 J6uTfGOPuj7R7QP.oVa6LtObWprU0Z5TrBCg8A6J97wM9Chq_U7rd5PwJE7TL5_dHQGn4agOux7m
 ZjpC4ZShzSkHGxxx38hL1fkfB4z9RcJwJRyBZROt_VO0kldawhQuQxbKyjqZ1xkgIHJIM4e0Lka8
 7DJftvs6inTNk2OOpXaRWthFaIoI2XWV.HydFs3Jegs747G3vES7u1czBe39OtU3nEdi1tznkttj
 Jz41ABNWGbYvIXDiDv1mYkUX3Zu3G57MoDeoK_ABtTUIFZSmWcYUlVVjnPGgYLHtJUqw6URg1AZW
 u9PMxFgNHPF_nFRTC7.7vd_VNDMOlv_fAm9HyJV0sAd5mKqstxbqG_IJVOprR4BTMX__ILT0Hw9i
 Azj0q2afD_NZCGCf.vBQqfv4rQvSk4PVcfiqRG.FqW6OOJm_N2Skr6RNFuX.eGC5fOjUH9nzIsZ9
 qvcwpCz_ILw5XhyAQUs5WKiqoHIZvgTcfrdWnFkUWxSbwVI6ODMWU2FYei3ryOsNXhA2rGRteaFU
 BcLBKuz0uk8rTbeG7CJhzVNsrFh65MkvZh.7X_sMe8A.IcWk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 6 Oct 2020 09:25:54 +0000
Date:   Tue, 6 Oct 2020 09:25:50 +0000 (UTC)
From:   Michel <micheldukuu@gmail.com>
Reply-To: mrmichelduku@outlook.com
Message-ID: <153836595.2424350.1601976350272@mail.yahoo.com>
Subject:  HELLO.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <153836595.2424350.1601976350272.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Greetings,

I know that this mail will come to you as a surprise as we have never met before, but need not to worry as I am contacting you independently of my investigation and no one is informed of this communication. I need your urgent assistance in transferring the sum of $11.3million immediately to your private account.The money has been here in our Bank lying dormant for years now without anybody coming for the claim of it.

I want to release the money to you as the relative to our deceased customer (the account owner) who died a long with his supposed Next Of Kin since 16th October 2005. The Banking laws here does not allow such money to stay more than 15 years, because the money will be recalled to the Bank treasury account as unclaimed fund.

By indicating your interest I will send you the full details on how the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Michel Duku.
