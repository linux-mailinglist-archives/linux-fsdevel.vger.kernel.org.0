Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435602FC3C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405573AbhASOdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:33:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35038 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbhASKuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:50:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JAiBXR005465;
        Tue, 19 Jan 2021 10:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k3Dmdvh68sp1sk7X+0gAHVikUR/XG2dKfI+/GpsLTbI=;
 b=KyhPoH6pvMukddNKhg9cIaZ6+9hdBXdTAeNS9dR+RL8prNKzVVMyjBuGp16bnryLLbvG
 UC4s/2+5oRzgaAxfa+8lHdRrwnm24ow0Dvj7FzwaU3A143ZlapvkbBdW/5PhVCjbS5Yg
 AHVlqIEre5yVRg0/HYVwriB+NvSlbKO/acaiBs+OI2JcEgSxSFlJITZ/lG/5BPKvsYGd
 O9UTyZa//2ZqQUhd2hWcIJ202XF4PX/KXrH//FJ3XJlJvzutCSshA57glXNrkhSpD9oZ
 i11dueZQw13TdUxc6yJAJ+Vyd1ibF7AbpLl55N/35UV38Y09fgsIfg6RH9SCgDBarv5O 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 363r3krfvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 10:44:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JAZeaD150113;
        Tue, 19 Jan 2021 10:44:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 364a2wf0a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 10:44:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JAhuXQ009341;
        Tue, 19 Jan 2021 10:43:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 02:43:56 -0800
Date:   Tue, 19 Jan 2021 13:43:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com
Subject: Re: [PATCH v17 01/10] fs/ntfs3: Add headers and misc files
Message-ID: <20210119104339.GA2674@kadam>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-2-almaz.alexandrovich@paragon-software.com>
 <20210103231755.bcmyalz3maq4ama2@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103231755.bcmyalz3maq4ama2@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190065
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 01:17:55AM +0200, Kari Argillander wrote:
> On Thu, Dec 31, 2020 at 06:23:52PM +0300, Konstantin Komarov wrote:
> 
> > +int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> > +		   const u16 *upcase)
> > +{
> > +	int diff;
> > +	size_t len = l1 < l2 ? l1 : l2;
> > +
> > +	if (upcase) {
> > +		while (len--) {
> > +			diff = upcase_unicode_char(upcase, le16_to_cpu(*s1++)) -
> > +			       upcase_unicode_char(upcase, le16_to_cpu(*s2++));
> > +			if (diff)
> > +				return diff;
> > +		}
> > +	} else {
> > +		while (len--) {
> > +			diff = le16_to_cpu(*s1++) - le16_to_cpu(*s2++);
> > +			if (diff)
> > +				return diff;
> > +		}
> > +	}
> > +
> > +	return (int)(l1 - l2);
> > +}
> 
> I notice that these functions might call both ignore case and upcase in a row.
> record.c - compare_attr()
> index.c - cmp_fnames()
> 
> So maybe we can add bool bothcases.
> 
> int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> 		   const u16 *upcase, bool bothcase)
> {
> 	int diff1 = 0;
> 	int diff2;
> 	size_t len = l1 < l2 ? l1 : l2;

size_t len = min(l1, l2);

I wonder if this could be a Coccinelle script?

regards,
dan carpenter
