Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06069B8BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBRI3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRI3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:29:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E653B218;
        Sat, 18 Feb 2023 00:29:40 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31I7l15E013923;
        Sat, 18 Feb 2023 08:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=/B1KfengwjDqZ4DY5Ku7JHkRAZJEEkM50wW+rCq75yY=;
 b=Cakpu6X/2DFnNf7hvDmOCSoX2Kk6LqT5fkJ1gBgrfR6dSu/EyEDeg0nrRQRmY5zXowjf
 EUYChvgTxdpk13pk4KIH6k0bLRuhQXqKw3UFXjHf+7qNE+se6mvOmNeuzKL/aj1VPOj3
 VmXP1HjZ09uAua4DFs8nHqH4mnsmcrdILsOeChK6gDkmI5+DnhGX1G42xh+1yFaTcHpi
 1d2YfBWbeL9nmfhrNY0/E+HJq0t2IRCLStTGCrxYevz4Nu40FdyW3+Z5h3WpaTw7kHO8
 w4QYPg2tpauSeyfZxENO/1XfXfHWwaoat59kY/fi6+kXRqDRn5/2dXGLIcoKh+fW8h72 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nttkc8gy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 08:29:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31I8S2rV002930;
        Sat, 18 Feb 2023 08:29:16 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nttkc8gxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 08:29:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31I2t4nT031088;
        Sat, 18 Feb 2023 08:29:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa68611-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 08:29:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31I8TBxs50004352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Feb 2023 08:29:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3BCA2004D;
        Sat, 18 Feb 2023 08:29:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C45620040;
        Sat, 18 Feb 2023 08:29:11 +0000 (GMT)
Received: from localhost (unknown [9.171.4.125])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 18 Feb 2023 08:29:11 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, axboe@kernel.dk, david@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without
 using ITER_PIPE
In-Reply-To: <732891.1676670463@warthog.procyon.org.uk>
In-Reply-To: 
References: <87a61ckowk.fsf@oc8242746057.ibm.com>
 <732891.1676670463@warthog.procyon.org.uk>
Date:   Sat, 18 Feb 2023 09:29:11 +0100
Message-ID: <87a61b9y20.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6U8DH4_SJ9EcGSWRq94cisg3kdYaZ3TG
X-Proofpoint-GUID: j-cDcyU2EI6447zlfftD4sjkH6r12ZRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-18_03,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302180070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,


David Howells <dhowells@redhat.com> writes:

> Does the attached fix the problem for you?  The data being written into the
> pipe needs to be limited to the size of the file.
>
> David
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c01bbcb9fa92..6362ac697a70 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2948,7 +2948,8 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  			if (writably_mapped)
>  				flush_dcache_folio(folio);
>  
> -			n = splice_folio_into_pipe(pipe, folio, *ppos, len);
> +			n = min_t(loff_t, len, isize - *ppos);
> +			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
>  			if (!n)
>  				goto out;
>  			len -= n;

Yes, this change fixed the problem.

Thanks
Regards
Alex
