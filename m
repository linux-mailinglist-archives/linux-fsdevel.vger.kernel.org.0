Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211941F19D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgFHNWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 09:22:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728022AbgFHNW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:22:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058D3b5B021977;
        Mon, 8 Jun 2020 09:22:14 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g713e5bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 09:22:14 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058DFWd2025273;
        Mon, 8 Jun 2020 13:22:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7sn22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:22:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058DMAvA63832214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 13:22:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C19F11C052;
        Mon,  8 Jun 2020 13:22:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 745E011C04C;
        Mon,  8 Jun 2020 13:22:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jun 2020 13:22:07 +0000 (GMT)
Message-ID: <1591622526.4638.71.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/8] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Date:   Mon, 08 Jun 2020 09:22:06 -0400
In-Reply-To: <20200608131630.GV19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
         <20200606050458.17281-2-scott.branden@broadcom.com>
         <20200606155216.GP19604@bombadil.infradead.org>
         <1591621401.4638.59.camel@linux.ibm.com>
         <20200608131630.GV19604@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_12:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=972
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080093
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-06-08 at 06:16 -0700, Matthew Wilcox wrote:
> On Mon, Jun 08, 2020 at 09:03:21AM -0400, Mimi Zohar wrote:
> > On Sat, 2020-06-06 at 08:52 -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
> > > > -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > > -		     loff_t max_size, enum kernel_read_file_id id)
> > > > -{
> > > > -	loff_t i_size, pos;
> > > > +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> > > > +		      loff_t pos, loff_t max_size,
> > > > +		      enum kernel_pread_opt opt,
> > > > +		      enum kernel_read_file_id id)
> > > > +{
> > > > +	loff_t alloc_size;
> > > > +	loff_t buf_pos;
> > > > +	loff_t read_end;
> > > > +	loff_t i_size;
> > > >  	ssize_t bytes = 0;
> > > >  	int ret;
> > > >  
> > > 
> > > Look, it's not your fault, but this is a great example of how we end
> > > up with atrocious interfaces.  Someone comes along and implements a
> > > simple DWIM interface that solves their problem.  Then somebody else
> > > adds a slight variant that solves their problem, and so on and so on,
> > > and we end up with this bonkers API where the arguments literally change
> > > meaning depending on other arguments.
> > > 
> > > > @@ -950,21 +955,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > >  		ret = -EINVAL;
> > > >  		goto out;
> > > >  	}
> > > > -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> > > > +
> > > > +	/* Default read to end of file */
> > > > +	read_end = i_size;
> > > > +
> > > > +	/* Allow reading partial portion of file */
> > > > +	if ((opt == KERNEL_PREAD_PART) &&
> > > > +	    (i_size > (pos + max_size)))
> > > > +		read_end = pos + max_size;
> > > > +
> > > > +	alloc_size = read_end - pos;
> > > > +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
> > > >  		ret = -EFBIG;
> > > >  		goto out;
> > > 
> > > ... like that.
> > > 
> > > I think what we actually want is:
> > > 
> > > ssize_t vmap_file_range(struct file *, loff_t start, loff_t end, void **bufp);
> > > void vunmap_file_range(struct file *, void *buf);
> > > 
> > > If end > i_size, limit the allocation to i_size.  Returns the number
> > > of bytes allocated, or a negative errno.  Writes the pointer allocated
> > > to *bufp.  Internally, it should use the page cache to read in the pages
> > > (taking appropriate reference counts).  Then it maps them using vmap()
> > > instead of copying them to a private vmalloc() array.
> > > 
> > > kernel_read_file() can be converted to use this API.  The users will
> > > need to be changed to call kernel_read_end(struct file *file, void *buf)
> > > instead of vfree() so it can call allow_write_access() for them.
> > > 
> > > vmap_file_range() has a lot of potential uses.  I'm surprised we don't
> > > have it already, to be honest.
> > 
> > Prior to kernel_read_file() the same or verify similar code existed in
> > multiple places in the kernel.  The kernel_read_file() API
> > consolidated the existing code adding the pre and post security hooks.
> > 
> > With this new design of not using a private vmalloc, will the file
> > data be accessible prior to the post security hooks?  From an IMA
> > perspective, the hooks are used for measuring and/or verifying the
> > integrity of the file.
> 
> File data is already accessible prior to the post security hooks.
> Look how kernel_read_file works:
> 
>         ret = deny_write_access(file);
>         ret = security_kernel_read_file(file, id);
>                 *buf = vmalloc(i_size);
>                 bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
>         ret = security_kernel_post_read_file(file, *buf, i_size, id);
> 
> kernel_read() will read the data into the page cache and then copy it
> into the vmalloc'd buffer.  There's nothing here to prevent read accesses
> to the file.

The post security hook needs to access to the file data in order to
calculate the file hash.  The question is whether prior to returning
from kernel_read_file() the caller can access the file data.

Mimi

